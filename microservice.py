
import os
import subprocess
import stat
from flask import Flask, request, jsonify

app = Flask(__name__)

# Shared simulation directory (inside the container)
SIM_DIR = os.environ.get('SIM_DIR', '/home/openfoam/simulation')

def make_executable(file_path):
    st = os.stat(file_path)
    os.chmod(file_path, st.st_mode | stat.S_IEXEC)

@app.route('/simulate', methods=['POST'])
def simulate():
    # Expect a JSON payload with 'job_folder' (relative to SIM_DIR)
    data = request.get_json()
    job_folder = data.get('job_folder')
    if not job_folder:
        return jsonify({'error': 'job_folder parameter is required'}), 400

    job_path = os.path.join(SIM_DIR, job_folder)
    if not os.path.isdir(job_path):
        return jsonify({'error': f'Job folder {job_path} does not exist'}), 400

    allrun_path = os.path.join(job_path, 'Allrun')
    if not os.path.isfile(allrun_path):
        return jsonify({'error': f'Allrun script not found in {job_path}'}), 400

    # Ensure Allrun is executable.
    make_executable(allrun_path)

    try:
        proc = subprocess.run(['./Allrun'], cwd=job_path, capture_output=True, text=True, check=True)
        output = proc.stdout
    except subprocess.CalledProcessError as e:
        return jsonify({'error': 'Simulation failed', 'details': e.stderr}), 500

    return jsonify({'success': True, 'output': output})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

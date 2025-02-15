# Vertical Repository Structure

This repository is organized to standardize vertical project development. Below is the folder structure and its purpose:
```
|__ documentation/
|   |__ file_1
|   |__ file_2
|   |__ ...
|
|__ use_cases/
|   |__ use_case_1/
|       |__ ...
|   |__ use_case_2/
|       |__ ...
|
|__ Dockerfile
|__ links.txt
|__ .gitignore
```

## Databases
You can easily download pre-computed databases for OpenFOAM from the links below:

| Name              | Size       | Link    |
|-------------------|------------------|-------------------|
| db_use_cases      | 28.9 MB    | [Download](https://drive.google.com/file/d/1TGszaKPLQm89o3uz7qsJGRZsE-qguQeO/view?usp=sharing) |
| db_documentations | 7.10 MB    | [Download](https://drive.google.com/file/d/1-ivGxLLxs3nuWUGNXRnIOtBXQoWMh-SR/view?usp=sharing) |

After downloading, you should extract them in your local environment within the same folder. This will result in the folder containing two additional folders:
- `db_use_cases`
- `db_documentations`

## Folder and File Descriptions

#### `documentation`

Documentation files explaining the functionality, design, or usage of the project. Add as many files as needed to ensure clarity.

#### `use_cases`

Each use case is stored as a subfolder containing relevant information, examples, and code specific to that case.

- Example: `use_case_1` might describe how to apply the application to a particular problem scenario.

- Example: `use_case_2` could include a real-world implementation or experiment.

#### `Dockerfile`

A Dockerfile for containerizing the application. This ensures the project environment is consistent and reproducible. Customize the Dockerfile according to the dependencies and runtime requirements of the project.

#### `links.txt (Optional)`

A text file containing external links relevant to the project, such as references, datasets, or related research. These links will be indexed for further use. Each line should include one link.

#### `.gitignore`

Defines files and directories that should not be tracked by Git. This file ensures that sensitive or unnecessary files are excluded from the repository.


## Notes

- The structure and naming conventions should remain consistent across all vertical repositories.
- Ensure every use case is well-documented and stored in its corresponding subfolder under use_cases.
- Do not modify .gitignore. It is configured to ensure best practices for repository cleanliness and security.
- By adhering to this structure, the repository will maintain clarity, reusability, and scalability for all stakeholders.

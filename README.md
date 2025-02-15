# Vertical Repository Structure

This repository is organized to standardize vertical project development. Below is the folder structure and its purpose:

```
|__ resources/
|   |__ documentations/
|   |   |__ file_1
|   |   |__ file_2
|   |   |__ ...
|   |
|   |__ use_cases/
|   |   |__ use_case_1/
|   |   |   |__ ...
|   |   |__ use_case_2/
|   |       |__ ...
|   |
|   |__ links.txt
|
|__ Dockerfile
|__ .gitignore
```

## Folder and File Descriptions

#### `resources/documentations`

Contains documentation files explaining the functionality, design, or usage of the project. Include as many files as needed to ensure clarity.

#### `resources/use_cases`

Each use case is stored as a subfolder containing relevant information, examples, and code specific to that case.

- *Example:* `use_case_1` might describe how to apply the application to a particular problem scenario.
- *Example:* `use_case_2` could include a real-world implementation or experiment.

#### `resources/links.txt (Optional)`

A text file containing external links relevant to the project, such as references, datasets, or related research. Each line should include one link.

#### `Dockerfile`

A Dockerfile for containerizing the application. This ensures the project environment is consistent and reproducible. Customize the Dockerfile according to the dependencies and runtime requirements of the project.

#### `.gitignore`

Defines files and directories that should not be tracked by Git. This file is configured to ensure that sensitive or unnecessary files are excluded from the repository.

## Notes

- The structure and naming conventions should remain consistent across all vertical repositories.
- Ensure every use case is well-documented and stored in its corresponding subfolder under `resources/use_cases`.
- Do not modify `.gitignore`. It is configured to ensure best practices for repository cleanliness and security.
- By adhering to this structure, the repository will maintain clarity, reusability, and scalability for all stakeholders.

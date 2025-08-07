# unsw-nb15-anomaly-detection
[![Python CI](https://github.com/githubfoam/unsw-nb15-anomaly-detection/actions/workflows/python-ci.yml/badge.svg)](https://github.com/githubfoam/unsw-nb15-anomaly-detection/actions/workflows/python-ci.yml)

UNSW-NB15 Anomaly Detection

Introduction

This repository contains a data science project for network anomaly detection using the UNSW-NB15 dataset. The project leverages an Isolation Forest model to identify suspicious network traffic patterns, which is a key task in cybersecurity.

Dataset

This project uses the UNSW-NB15 dataset, which was created by the IXIA PerfectStorm tool in the Cyber Range Lab of UNSW Canberra. The raw network packets were captured using the tcpdump tool, resulting in 100 GB of raw traffic. The dataset contains nine types of attacks, including Fuzzers, Analysis, Backdoors, DoS, Exploits, Generic, Reconnaissance, Shellcode, and Worms.

Using the Argus and Bro-IDS tools, 49 features were generated, which are described in the UNSW-NB15_features.csv file. The total dataset consists of over 2.5 million records, distributed across four CSV files: UNSW-NB15_1.csv, UNSW-NB15_2.csv, UNSW-NB15_3.csv, and UNSW-NB15_4.csv. Ground truth information is available in the UNSW-NB15_GT.csv file, and a list of events is in UNSW-NB15_LIST_EVENTS.csv. The dataset is also available in pre-partitioned training and testing sets.

The official source for the dataset and its documentation can be found here:
https://research.unsw.edu.au/projects/unsw-nb15-dataset

Repository Structure

The project's directory structure is organized as follows:

.github/workflows/
├── python-ci.yml           # Stable CI workflow
notebooks/
├── isolation_forest_model.pkl    # Pre-trained Isolation Forest model
├── scaler.pkl                  # Data scaler for preprocessing
└── unsw_nb15_anomaly_detection.ipynb
.gitignore
LICENSE
README.md
requirements.txt

    .github/workflows/: Contains the GitHub Actions workflow files for Continuous Integration.

    notebooks/: Holds the Jupyter notebook and the project's assets.

        Why are they stored?
        The isolation_forest_model.pkl (the trained model) and scaler.pkl (the data scaler) are stored to eliminate the need for time-consuming re-training and re-fitting processes. Training the model on the large UNSW-NB15 dataset is computationally intensive. By saving these files after they are created, we can ensure consistent results and a faster workflow.

        How are they used?
        These files are loaded directly into the notebook using a library like pickle. The scaler.pkl is loaded first to transform raw input data into the same format the model was trained on. Then, the isolation_forest_model.pkl is loaded to make predictions on the preprocessed data, allowing for quick and efficient anomaly detection without repeating the initial setup steps.

    requirements.txt: Lists all the necessary Python libraries for this project.

CI/CD Workflow

This repository uses a GitHub Actions workflow defined in .github/workflows/python-ci.yml to ensure code quality. The workflow automatically:

    Installs project dependencies.

    Downloads the UNSW-NB15 dataset from a private Kaggle repository using encrypted repository secrets for secure authentication.

    Executes the Jupyter notebook to confirm all cells run without errors.

The workflow is triggered on every push and pull request to the main branch and runs on a daily schedule to monitor for any regressions.

Jupyter Notebook Walkthrough

The unsw_nb15_anomaly_detection.ipynb notebook provides a complete, end-to-end data science pipeline for network anomaly detection. Here's a brief breakdown of what each section of the notebook does:

    Data Loading: It first loads the four UNSW-NB15_*.csv files and merges them into a single pandas DataFrame, providing an initial look at the dataset's raw structure and size.

    Preprocessing: This section prepares the data for modeling by handling categorical features with LabelEncoder and filling any missing values.

    Feature Scaling: The preprocessed data is then scaled using StandardScaler, a crucial step for many machine learning algorithms to ensure all features are on a comparable scale.

    Model Training: An Isolation Forest model is trained on the prepared data. This unsupervised learning algorithm is ideal for anomaly detection, as it works by isolating observations that are distinct from the majority.

    Prediction and Analysis: After training, the notebook uses the model to predict anomalies and adds these predictions to the DataFrame. It then visualizes the results to show the number of detected anomalies.

    Saving the Model: Finally, the notebook uses joblib to save the trained Isolation Forest model and the fitted StandardScaler to .pkl files. This step allows you to reuse the trained model without having to retrain it.

How to Use

To run this project locally, follow these steps:

    Clone the repository:
    Bash

git clone https://github.com/githubfoam/unsw-nb15-anomaly-detection.git

Navigate to the project directory:
Bash

cd unsw-nb15-anomaly-detection

Create a virtual environment (recommended):
Bash

python -m venv venv
source venv/bin/activate

Install the required dependencies:
Bash

pip install -r requirements.txt

Launch Jupyter and open the notebook to get started. You can run the cells sequentially to reproduce the entire anomaly detection workflow.
Bash

    jupyter notebook

License

This project is licensed under the MIT License. See the LICENSE file for details.
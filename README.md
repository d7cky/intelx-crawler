# IntelX Crawler

This tool is designed to crawl data from IntelX and process it using Python. The tool can be run manually or within a Docker container for easy deployment and execution.

## Features

- Crawl data from IntelX using provided API key.
- Process crawled data and save unique results.
- Containerized for easy setup and execution.

## Requirements

- Python 3.6+
- IntelX API Key

## Manual Setup and Usage

### Setup

1. **Clone the repository**:
    ```bash
    git clone https://github.com/d7cky/intelx-crawler.git
    cd intelx-crawler
    ```

2. **Install the required Python packages**:
    ```bash
    pip install -r requirements.txt
    ```

3. **Install the intelxapi library**:
    ```bash
    pip install "intelx @ git+https://github.com/IntelligenceX/SDK#subdirectory=Python"
    ```

### Usage

1. **Run the script on Linux**:
    ```bash
    chmod +x run.sh
    ./run.sh -q "your_query" -k "your_api_key" -o "output.txt"
    ```

2. **Run the script on Windows**:
    ```bat
    ./run.bat -q "your_query" -k "your_api_key" -o "output.txt"

Replace `your_query`, `your_api_key`, and `output.txt` with the appropriate values.

## Docker Setup and Usage

### Setup

1. **Pull the Docker image**:
    ```bash
    docker pull quangduc280497/intelx-crawler:v1
    ```

### Usage

1. **Run the Docker container with the necessary parameters**:
    ```bash
    docker run --rm -it -v "$(pwd)/output:/app/output" intelx-crawler "your_query" "your_api_key" "output.txt"
    ```

Replace `your_query`, `your_api_key`, and `output.txt` with the appropriate values.

### Accessing the Results

After the container has finished running, you can find the results in the `output` directory:
- `output.txt`: Raw output file
- `unique.txt`: Unique results
- `result.txt`: Final filtered results

### Contributing

If you want to contribute to this project, please fork the repository and submit a pull request.

### Contact
If you have any questions, please contact us at d3cky.duck@gmail.com.
# csv-file-to-json-file-converter
A simple python script that will convert a csv file and export a json formatted file.

> When you clone your project to another device, the requirements.txt file is there to ensure you have all the necessary dependencies installed. However, if you want to avoid installing the packages listed in requirements.txt again, you have a few options:

## 1. Using a Pre-built Virtual Environment
You can create a pre-built virtual environment that you can use across multiple devices. This approach involves creating the virtual environment and copying it to your other devices. Note that this approach may have limitations due to differences in operating systems or Python versions.

1. Create and Set Up Virtual Environment on the First Device:

``` bash
python3 -m venv myenv
source myenv/bin/activate
pip install -r requirements.txt
```
2. Zip the Virtual Environment:

```bash
deactivate
zip -r myenv.zip myenv
Transfer the Zip File to Another Device:
```
3. Copy the myenv.zip file to your other device.

Unzip and Activate the Virtual Environment on the Other Device:

```bash
unzip myenv.zip
source myenv/bin/activate  # On Unix or MacOS
.\myenv\Scripts\activate  # On Windows
```

## 2. Docker
Using Docker is a robust way to ensure your environment is consistent across different devices. Docker packages your application along with all its dependencies into a container that can run on any system with Docker installed.

1. Create a Dockerfile:

```dockerfile
### Use an official Python runtime as a parent image
FROM python:3.8-slim

### Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run main.py when the container launches
CMD ["python", "./main.py"]
```

2. Build the Docker Image:

``` bash
docker build -t my-python-app .
Run the Docker Container:
```

``` bash
docker run -it --rm --name my-running-app my-python-app
```

3. Using the Pre-built Executable
If you've already built a standalone executable using pyinstaller, you can distribute this executable to other devices without needing to set up a virtual environment or install dependencies again.

1. Build the Executable:

```bash
pyinstaller --onefile main.py
```

2. Distribute the Executable:
Copy the executable from the dist directory to your other device. You can run it directly:

```bash
./dist/main path/to/yourfile.csv  # On Unix or MacOS
dist\main.exe path\to\yourfile.csv  # On Windows
```

## Summary
- Pre-built Virtual Environment: Zip and transfer the virtual environment.
- Docker: Use Docker to package your application and its dependencies.
- Pre-built Executable: Use pyinstaller to create a standalone executable.

Each of these methods has its advantages and can be chosen based on your specific use case and environment constraints.
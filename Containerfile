# Start with a minimal Python image
FROM python:3.10-slim
 
# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=${PATH}:${JAVA_HOME}/bin:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools
 
# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    unzip \
    git \
    xz-utils \
    default-jdk \
    gnupg \
    sudo \
    lib32stdc++6 \
    lib32z1 \
    usbutils \
    android-tools-adb \
    nano \
    lsof \
    adb \
    iputils-ping \
    net-tools \
&& apt-get clean && rm -rf /var/lib/apt/lists/*
 
# Verify Java
RUN java -version
 
# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
&& apt-get update && apt-get install -y --no-install-recommends nodejs \
&& apt-get clean && rm -rf /var/lib/apt/lists/*
 
# Install Python libraries
RUN pip install --no-cache-dir \
    robotframework \
    robotframework-seleniumlibrary \
    robotframework-appiumlibrary \
    appium-python-client \
    robotframework-pabot
 
# Install Appium CLI & Doctor
RUN npm install -g appium@latest appium-doctor
 
# Set up Android SDK
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -O /tmp/cmdline-tools.zip && \
    unzip -q /tmp/cmdline-tools.zip -d ${ANDROID_HOME}/cmdline-tools && \
    mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest && \
    rm /tmp/cmdline-tools.zip
 
# Accept licenses and install packages
RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3" "tools" "emulator"
 
# Install ChromeDriver
RUN CHROMEDRIVER_VERSION=$(curl -s https://chromedriver.storage.googleapis.com/LATEST_RELEASE) && \
    wget -q https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip -O /tmp/chromedriver.zip && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin/ && \
    rm /tmp/chromedriver.zip && \
    chmod +x /usr/local/bin/chromedriver
 
    # Install TTYD (terminal over WebSocket)
    RUN wget -q https://github.com/tsl0922/ttyd/releases/latest/download/ttyd.x86_64 && \
    chmod +x ttyd.x86_64 && \
    mv ttyd.x86_64 /usr/local/bin/ttyd
 
 
# Create app user
RUN groupadd -r adbusers && \
    useradd -m -s /bin/bash -G adbusers appuser && \
    echo "appuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
 
# Prepare directory and ownership
RUN mkdir -p /app/tests && chown -R appuser:appuser /app
 
# Copy scripts and test files
COPY --chown=appuser:appuser start.sh /app/start.sh
COPY --chown=appuser:appuser imommy.robot /app/imommy.robot
 
 
# Make script executable
RUN chmod +x /app/start.sh
 
# Switch to non-root user
USER appuser
 
# Install uiautomator2 driver
RUN appium driver install uiautomator2
 
# Working directory
WORKDIR /app
 
# Expose ports for Appium and gotty terminal
EXPOSE 4723 5555 8080 8085
 
# Default CMD
CMD ["/bin/bash", "/app/start.sh"]
# Use the Debian stable-slim base image
FROM debian:stable-slim

# Set the maintainer information
MAINTAINER OIVAS7572

# Print a message
RUN echo OIVAS7572

# Copy the current directory into the container
COPY . .

# Update package lists and install necessary packages
RUN apt update > aptud.log && apt install -y wget python3 python3-pip p7zip-full unzip > apti.log

# Install Python dependencies from requirements.txt
RUN python3 -m pip install --no-cache-dir -r requirements.txt > pip.log

# Download and extract Goi5.1.bin
RUN wget --no-check-certificate -nv "https://gitlab.com/OIVAS7572/Goi5.1.bin/-/raw/main/Goi5.1.bin.7z" -O Goi5.1.bin.7z \
    && 7z e Goi5.1.bin.7z && rm Goi5.1.bin.7z && mv Goi5.1.bin engines/books/Goi5.1.bin

# Download and install Stockfish
RUN wget https://abrok.eu/stockfish/latest/linux/stockfish_x64_bmi2.zip -O stockfish.zip
RUN unzip stockfish.zip && rm stockfish.zip
RUN mv stockfish_* engines/stockfish && chmod +x engines/stockfish

# Make sure the Stockfish binary is executable
RUN chmod +x engines/stockfish

# Set the command to run when the container starts
CMD python3 lichess-bot.py -u

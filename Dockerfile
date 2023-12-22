FROM debian:stable-slim
MAINTAINER OIVAS7572
RUN echo OIVAS7572
COPY . .

# If you want to run any other commands use "RUN" before.

RUN apt update > aptud.log && apt install -y wget python3 python3-pip p7zip-full > apti.log
RUN python3 -m pip install --no-cache-dir -r requirements.txt > pip.log

RUN wget --no-check-certificate -nv "https://gitlab.com/OIVAS7572/Goi5.1.bin/-/raw/main/Goi5.1.bin.7z" -O Goi5.1.bin.7z \
&& 7z e Goi5.1.bin.7z && rm Goi5.1.bin.7z && mv Goi5.1.bin engines/books/Goi5.1.bin

# Stockfish - Depending on your CPU it may be necessary to pick a binary other than bmi2
RUN wget https://abrok.eu/stockfish/latest/linux/stockfish_x64_bmi2.zip -O stockfish.zip
RUN 7z e stockfish.zip && rm stockfish.zip
RUN mv stockfish_* engines/stockfish && chmod +x engines/stockfish

RUN chmod +x engines/stockfish
#Engine name ^^^^^^^^^^^^^^^^^^^

CMD python3 lichess-bot.py -u

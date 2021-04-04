FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=non-interactive

RUN apt-get update && apt-get install -y \
    git \
    vim \
    python3 \
    python3-pip \
    wget \
    unzip \
    build-essential \
    cmake \
    vim-nox \
    python3-dev \
    mono-complete \
    golang \
    nodejs \
    default-jdk \
    npm

#anavision user
RUN useradd -ms /bin/bash anavision
USER anavision
WORKDIR /home/anavision

#conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN chmod 755 /home/anavision/Miniconda3-latest-Linux-x86_64.sh
RUN ["/bin/bash", "-c", "/home/anavision/Miniconda3-latest-Linux-x86_64.sh -b"]
RUN /home/anavision/miniconda3/bin/conda create -n pytorch_anavision
RUN echo "source activate pytorch_anavision" >> /home/anavision/.bashrc
ENV PATH /home/anavision/miniconda3/bin:$PATH
RUN conda update conda
RUN conda config --add channels conda-forge
RUN conda update --all

#install pytorch 1.7.1. 1.8 doesnt work with the example
RUN conda install pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 cudatoolkit=11.0 -c pytorch
#RUN conda install pytorch torchvision torchaudio cudatoolkit=11.1 numpy -c pytorch -c conda-forge -n pytorch_anavision

#explicity state other development goodies
RUN pip install scikit-image

#install the stuff used in https://colab.research.google.com/github/pytorch/vision/blob/temp-tutorial/tutorials/torchvision_finetuning_instance_segmentation.ipynb
RUN ["/bin/bash", "-c", "source activate pytorch_anavision && pip install cython"]
RUN ["/bin/bash", "-c", "source activate pytorch_anavision && pip install -U 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI'"]
# Download TorchVision repo to use some files from references/detection
RUN mkdir -p /home/anavision/examples/torchvision_finetuning_instance_segmentation && cd examples/torchvision_finetuning_instance_segmentation &&\
    wget https://www.cis.upenn.edu/~jshi/ped_html/PennFudanPed.zip &&\
    unzip PennFudanPed.zip &&\
    git clone https://github.com/pytorch/vision.git &&\
    cd vision &&\
    git checkout v0.3.0 &&\
    cp references/detection/utils.py ../ &&\
    cp references/detection/transforms.py ../ &&\
    cp references/detection/coco_eval.py ../ &&\
    cp references/detection/engine.py ../ &&\
    cp references/detection/coco_utils.py ../ &&\
    cd ..
COPY ./examples/main.py /home/anavision/examples/torchvision_finetuning_instance_segmentation 

#Install other dependencies (toxic_algae)
RUN ["/bin/bash", "-c", "source activate pytorch_anavision && pip install -U scikit-image"]
RUN ["/bin/bash", "-c", "source activate pytorch_anavision && pip install PyYAML"]
    
#Setup Vim
RUN git clone https://github.com/VundleVim/Vundle.vim.git /home/anavision/.vim/bundle/Vundle.vim
RUN ["/bin/bash", "-c", "echo hii"]
COPY --chown=anavision  ./.vimrc_plugin_install /home/anavision
RUN vim -u .vimrc_plugin_install +PluginInstall +qall
RUN ["/bin/bash", "-c", "cd /home/anavision/.vim/bundle/YouCompleteMe && python3 install.py --all"]
RUN rm ./.vimrc_plugin_install
COPY --chown=anavision  ./.vimrc /home/anavision


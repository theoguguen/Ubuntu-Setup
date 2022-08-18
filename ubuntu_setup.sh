#!/bin/bash
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'
PURPLE='\033[0;35m'
DIR=$PWD
NAME=$USER

function dependencies()
{
    echo -ne "${GREEN}[#####                  ](33%)\r"
    sudo apt install -y ruby make gcc pip curl wget emacs bat &>/dev/null
    sleep 1
    echo -ne '[#############          ](66%)\r'
    sudo apt install -y git python3 tree build-essential libcsfml-dev g++ &>/dev/null
    sleep 1
    echo -ne '[#######################](100%)\r'
    echo -ne '\n'
}

function norm()
{
    echo -ne "${GREEN}[#####                  ](33%)\r"
    sudo python3 -m pip install pycparser pyparsing pycparser-fake-libc &>/dev/null
    sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/aureliancnx/Bubulle-Norminette/master/install_bubulle.sh)" &>/dev/null
    sleep 1
    echo -ne '[#############          ](66%)\r'
    cd /tmp
    git clone https://github.com/ronanboiteau/NormEZ &>/dev/null && cd NormEZ && sudo make install &>/dev/null
    cd $DIR
    sleep 1
    echo -ne '[#######################](100%)\r'
    echo -ne "\n${NC}"
}

function shell()
{
    echo -e "${PURPLE}Installing zsh..."
    echo -ne "${GREEN}[#####                  ](33%)\r"
    sudo apt install -y zsh &>/dev/null
    zsh
    sleep 1
    echo -ne '[#############          ](66%)\r'
    sudo sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    cp ./robbyrussell.zsh-theme ~/.oh-my-zsh/themes/
    sleep 1
    echo -ne '[#######################](100%)\r'
    echo -ne '\n'
}

function ide()
{
    echo -ne "${GREEN}[#####                  ](33%)\r"
    cd /tmp && wget https://az764295.vo.msecnd.net/stable/e4503b30fc78200f846c62cf8091b76ff5547662/code_1.70.2-1660629410_amd64.deb &>/dev/null
    sleep 1
    echo -ne '[#############          ](66%)\r'
    sudo apt install -y ./code_1.70.2-1660629410_amd64.deb &>/dev/null
    sleep 1
    echo -ne '[#######################](100%)\r'
    echo -ne '\n'
    rm code_1.70.2-1660629410_amd64.deb &>/dev/null
}

function aliases()
{
    echo -ne "${GREEN}[#####                  ](33%)\r"
    echo "alias ne=emacs -nw" >> ~/.zshrc
    echo "alias bb=clear && bubulle" >> ~/.zshrc
    echo "alias fclean=make fclean && clear" >> ~/.zshrc
    sleep 1
    echo -ne '[#############          ](66%)\r'
    echo "alias re=clear && make re" >> ~/.zshrc
    echo "alias norm=clear && normez" >> ~/.zshrc
    echo "alias bat=batcat" >> ~/.zshrc
    sleep 1
    echo -ne '[#######################](100%)\r'
    echo -ne '\n'
}

clear
echo -e "${PURPLE}Removing password prompt for sudo..."
sudo cp /etc/sudoers .temp
sudo chmod 777 .temp
echo "$USER ALL=(ALL) NOPASSWD:ALL" >> .temp
sudo cp .temp /etc/sudoers
rm .temp
echo -e "${PURPLE}Installing Dependencies..."
dependencies

echo -e "${PURPLE}Installing Norm Checker..."
norm

read -p 'Do you want to install zsh ? [Y/N] ' answer
if [ "$answer" == "y" ] || [ "$answer" == "Y" ]
then
    which zsh &>/dev/null
    if [ $? -eq 1 ]
    then
        shell
    else
        echo -e "${RED}You already have zsh.${NC}"
    fi
fi

if [ ! -f /bin/code ]
then
    echo -e "${PURPLE}Installing vscode..."
    ide
fi

echo -e "${PURPLE}Adding aliases..."
aliases

echo -e "${PURPLE}Updating packages..."
echo -ne "${GREEN}[#####                  ](33%)\r"
sudo apt update &>/dev/null && sudo apt upgrade -y &>/dev/null
sleep 1
echo -ne '[#############          ](66%)\r'
sudo apt-get update &>/dev/null && sudo apt-get upgrade -y &>/dev/null
sleep 1
echo -ne '[#######################](100%)\r'
echo -ne '\n'

#!/usr/bin/env bash

# ZVM install script - v0.1.5 - ZVM: https://github.com/tristanisham/zvm



ARCH=$(uname -m)
OS=$(uname -s)


if [ $ARCH = "x86_64" ]; then
    ARCH="amd64"
fi

# echo "Installing zvm-$OS-$ARCH"

install_latest() {
    echo -e "Installing $1 in $(pwd)/zvm"
    if [ "$(uname)" = "Darwin" ]; then
     # Do something under MacOS platform

        if command -v wget >/dev/null 2>&1; then
    
            echo "wget is installed. Using wget..."
            wget -q --show-progress --max-redirect 5 -O zvm.tar "https://github.com/tristanisham/zvm/releases/latest/download/$1"
        else
            echo "wget is not installed. Using curl..."
            curl -L --max-redirs 5 "https://github.com/tristanisham/zvm/releases/latest/download/$1" -o zvm.tar
        fi
        
        mkdir -p $HOME/.zvm/self
        tar -xf zvm.tar -C $HOME/.zvm/self
        rm "zvm.tar"
        
    elif [ $OS = "Linux" ]; then
     # Do something under GNU/Linux platform
        if command -v wget >/dev/null 2>&1; then
    
            echo "wget is installed. Using wget..."
            wget -q --show-progress --max-redirect 5 -O zvm.tar "https://github.com/tristanisham/zvm/releases/latest/download/$1"
        else
            echo "wget is not installed. Using curl..."
            curl -L --max-redirs 5 "https://github.com/tristanisham/zvm/releases/latest/download/$1" -o zvm.tar
        fi
        
        mkdir -p $HOME/.zvm/self
        tar -xf zvm.tar -C $HOME/.zvm/self
        rm "zvm.tar"
    elif [ $OS = "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
        curl -L --max-redirs 5 "https://github.com/tristanisham/zvm/releases/latest/download/$($1)" -o zvm.zip

    elif [ $OS == "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
        curl -L --max-redirs 5 "https://github.com/tristanisham/zvm/releases/latest/download/$($1)" -o zvm.zip

    fi
}



if [ "$(uname)" = "Darwin" ]; then
    # Do something under Mac OS X platform
    install_latest "zvm-darwin-$ARCH.tar"
elif [ $OS = "Linux" ]; then
     # Do something under GNU/Linux platform
    install_latest "zvm-linux-$ARCH.tar"
elif [ $OS = "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
    install_latest "zvm-windows-$ARCH.zip"
elif [ $OS == "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
    install_latest "zvm-windows-$ARCH.zip"
fi

echo
echo "Run the following commands to put ZVM on your path via $HOME/.profile"
echo 
# Check if TERM is set to a value that typically supports colors
if [[ "$TERM" == "xterm" || "$TERM" == "xterm-256color" || "$TERM" == "screen" || "$TERM" == "tmux" ]]; then
    # Colors
    RED='\033[0;31m'        # For strings
    GREEN='\033[0;32m'      # For commands
    BLUE='\033[0;34m'       # For variables
    NC='\033[0m'            # No Color

    echo -e "${GREEN}echo${NC} ${RED}\"# ZVM\"${NC} ${GREEN}>>${NC} ${BLUE}\$HOME/.profile${NC}"
    echo -e "${GREEN}echo${NC} ${RED}'export ZVM_INSTALL=\"\$HOME/.zvm/self\"'${NC} ${GREEN}>>${NC} ${BLUE}\$HOME/.profile${NC}"
    echo -e "${GREEN}echo${NC} ${RED}'export PATH=\"\$PATH:\$HOME/.zvm/bin\"'${NC} ${GREEN}>>${NC} ${BLUE}\$HOME/.profile${NC}"
    echo -e "${GREEN}echo${NC} ${RED}'export PATH=\"\$PATH:\$ZVM_INSTALL/\"'${NC} ${GREEN}>>${NC} ${BLUE}\$HOME/.profile${NC}"

    echo -e "Run '${GREEN}source ~/.profile${NC}' to start using ZVM in this shell!"

else
    echo 'echo "# ZVM" >> $HOME/.profile'
    echo 'echo '\''export ZVM_INSTALL="$HOME/.zvm/self"'\'' >> $HOME/.profile'
    echo 'echo '\''export PATH="$PATH:$HOME/.zvm/bin"'\'' >> $HOME/.profile'
    echo 'echo '\''export PATH="$PATH:$ZVM_INSTALL/"'\'' >> $HOME/.profile'

    echo "Run 'source ~/.profile' to start using ZVM in this shell!"

fi
    
echo

#!/bin/bash
python2_setup () {
        sudo apt-get update -y
        sudo apt-get install -y build-essential git libdistorm3-dev libraw1394-11 libcapstone-dev capstone-tool tzdata yara
        sudo apt-get install -y python2 python2.7-dev libpython2-dev
}
python3_setup () {
        sudo apt-get install -y python3 python3-dev libpython3-dev python3-pip python3-setuptools python3-wheel
}
volatility2 () {
        USER=$(whoami)
        curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
        python2 get-pip.py
        rm get-pip.py
        python2 -m pip install -U setuptools wheel
        python2 -m pip install -U distorm3 pycrypto pillow openpyxl ujson pytz ipython capstone #yara #Might cause issues on newer versions of Python 
        python2 -m pip install -U git+https://github.com/volatilityfoundation/volatility.git
        #sudo ln -s /home/$USER/.local/lib/python2.7/site-packages/usr/lib/libyara.so /usr/lib/libyara.so 
}
volatility3 () {
        USER=$(whoami)
        VERSION=$(python3 -V | awk '{print $2}' | grep -Po '^[0-9]+\.[0-9]+')
        python3 -m pip install -U distorm3 pycrypto pillow openpyxl ujson pytz ipython capstone #yara
        python3 -m pip install -U git+https://github.com/volatilityfoundation/volatility3.git
        sed -i 's/xrange/range/g' /home/$USER/.local/lib/python$VERSION/site-packages/Crypto/Cipher/ARC4.py
}
python2_setup
python3_setup
volatility2
volatility3

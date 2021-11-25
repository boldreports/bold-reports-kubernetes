# Install PhantomJS

> **Important:** PhantomJS is a headless WebKit scriptable with JavaScript. This is free software or open source, and it may contain MIT, BSD, LGPL, GPL, or other similar licenses that contain third-party code. This executable file is necessary to export the data visualization report items during report schedule.

1. Please run the below command for bash into your pod for installing the PhantomJS:

    ```sh
    kubectl exec -it <reports-web_Deployment_Name> -n <your_namespace> -- bash
    ```
	
2. Move to the optional library folder with the following command:

    ```sh
    cd /application/app_data/optional-libs
    ```

3. Before installing PhantomJS, you will need to install some required packages on your linux system . You can install all of them with the following command:

    ```sh
    sudo apt-get install build-essential chrpath libssl-dev libxft-dev libfreetype6-dev libfreetype6 libfontconfig1-dev libfontconfig1 -y
    ```

4. You will need to download the PhantomJS. You can download the latest stable version of the PhantomJS from their official website. Run the following command to download PhantomJS.

    ```sh
    sudo wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
    ```

5. Once the download is complete, extract the downloaded archive file to desired system location:

    ```sh
    sudo tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/
    ```

6. Next, create a symlink of PhantomJS binary file to systems bin directory:

    ```sh
   sudo ln -s /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/
    ```

7. Verify PhantomJS installed on your system with the following command:

    ```sh
   phantomjs --version
    ```

8. You can see the following PhantomJS version

    ```sh
   2.1.1
    ```

> **Note:** PhantomJS needs some dependencies. If your distribution does not contain the dependencies, please install it. [https://phantomjs.org/download.html](https://phantomjs.org/download.html).
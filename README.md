Pentru a rula exemplele aveti nevoie de un sistem Linux cu Docker instalat. 
Urmati linkurile de instalare din prezentare.

Daca cerintele sunt indeplinite:

    $ git clone https://github.com/vladbalmos/docker-presentation
    $ cd docker-presentation
    $ make install
    $ make
  
Adaugati in /etc/hosts

    127.0.0.1 wordpress-docker.d
  
Accesati in browser http://wordpress-docker.d:28080

Comenzile docker folosite pentru a crea imaginile si containerele din prezentare sunt enumerate in fisierul Makefile.


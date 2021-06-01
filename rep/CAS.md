# Url du serveur CAS
CAS_SERVER_URL = 'https://cas.imtbs-tsp.eu/cas/'

# Version du serveur
CAS_VERSION = '3'

# L'url sur lequel l'utilisateur est redirigé une fois connecté
CAS_LOGIN_URL_NAME = 'login'
CAS_LOGOUT_URL_NAME = 'logout_cas'
CAS_REDIRECT_URL = "/home/"

# Les attributs retournés par le cas
CAS_RENAME_ATTRIBUTES = {'mail': 'email',
                         'givenName': 'first_name',
                         'sn': 'last_name'}
                         
                         
                         
                    LDAP     sudo ssh jovart_a@sshmaster.imtbs-tsp.eu:22 –L 389:157.159.10.70:389
                cléprivé    sudo ssh -L 389:157.159.10.70:389 jovart_a@sshmaster.imtbs-tsp.eu -i ./.ssh/id_rsa

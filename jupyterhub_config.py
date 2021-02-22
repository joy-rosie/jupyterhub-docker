
c.Spawner.cmd = ['jupyter-labhub']

c.Jupyterlab.confirm_no_ssl = True

c.JupyterHub.admin_users = {'admin'}

from firstuseauthenticator import FirstUseAuthenticator
from jupyterhub.auth import LocalAuthenticator
class MyAuthenticator(FirstUseAuthenticator, LocalAuthenticator):
    ... 
 
c.JupyterHub.authenticator_class = MyAuthenticator
c.LocalAuthenticator.create_system_users = True

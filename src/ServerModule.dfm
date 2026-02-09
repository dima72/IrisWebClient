object UniServerModule: TUniServerModule
  OnCreate = UniGUIServerModuleCreate
  OnDestroy = UniGUIServerModuleDestroy
  TempFolder = 'temp\'
  Title = 'New Application'
  SuppressErrors = []
  Bindings = <>
  CustomFiles.Strings = (
    'login.html')
  ServerLimits.MaxSessions = 30
  SSL.SSLOptions.RootCertFile = 'root.pem'
  SSL.SSLOptions.CertFile = 'cert.pem'
  SSL.SSLOptions.KeyFile = 'key.pem'
  SSL.SSLOptions.Method = sslvSSLv23
  SSL.SSLOptions.SSLVersions = [sslvTLSv1_1, sslvTLSv1_2]
  SSL.SSLOptions.Mode = sslmUnassigned
  SSL.SSLOptions.VerifyMode = []
  SSL.SSLOptions.VerifyDepth = 0
  ConnectionFailureRecovery.ErrorMessage = 'Connection Error'
  ConnectionFailureRecovery.RetryMessage = 'Retrying...'
  OnHTTPCommand = UniGUIServerModuleHTTPCommand
  Height = 480
  Width = 640
  object TestConnection: TFDConnection
    Left = 24
    Top = 24
  end
end

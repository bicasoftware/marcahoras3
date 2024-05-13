enum WebMethod {
  get('GET'),
  head('HEAD'),
  post('POST'),
  put('PUT'),
  delete('DELETE'),
  connect('CONNECT'),
  options('OPTIONS'),
  trace('TRACE'),
  patch('PATCH'),
  error('ERROR');

  final String methodString;

  const WebMethod(this.methodString);
}

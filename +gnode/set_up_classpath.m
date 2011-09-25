function nothing = set_up_classpath()

  javaaddpath('/home/aleonhardt/matlab-client/gnode-client-lib/target/gnode-client-lib-assembly-0.2.jar');
  clear java;
  java.lang.System.clearProperty('https.proxyPort');
  java.lang.System.clearProperty('http.proxyPort');

end

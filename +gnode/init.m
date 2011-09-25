function session = init(filename, password, server)

  import gnode.*;

  set_up_classpath();

  import org.gnode.lib.client.*;
  import org.gnode.lib.conf.*;

  if (nargin == 1)

    if (strcmp(filename, 'default'))
      filename = '/home/aleonhardt/gnode/aljoscha.json';
    end
  
    settings_some = ConfigurationReader.fromFile(filename);
    try
      settings = settings_some.get();
    catch
      settings = Default.CONFIGURATION;
    end

  elseif (nargin == 3)

    c = Default.CONFIGURATION;
    settings = ConfigurationReader.create(filename, password, server, c.port, c.path, c.apiDefinition, c.caching, c.db);

  else

    settings = Default.CONFIGURATION;

  end
	 
  t = TransferManager(settings);

  session.connector = t;
  session.settings = settings;

end

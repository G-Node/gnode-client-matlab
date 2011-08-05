function session = init(filename)

	 if (nargin < 1),
	    error('[GNODE] No configuration specified');
	 end

	 if (filename == 'default'),
	    filename = fullfile(pwd, '/default-config.json');
	 end
	 
	 import gnode.*;

	 set_up_classpath();

	 import org.gnode.lib.*;
	 import org.gnode.lib.conf.*;

	 % Configuration reader emits a Scala object of type:
	 %   Option[Configuration]
	 % which provides stronger null safety.
	 %
	 % Actual instance retrievable via get()-method.

	 settings_some = ConfigurationReader.fromFile(filename);
	 settings = settings_some.get();
	 
	 c = Connector(settings);

	 session.connector = c;
	 session.settings = settings;

end
	 

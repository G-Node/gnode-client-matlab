function authenticate(session)

	 import org.gnode.lib.*;

	 if (nargin < 1),
	    error('[GNODE] No session instance specified');
	 end

	 if (strfind('Connector', class(session.connector)) == []),
	    error('[GNODE] Invalid session instance');
	 end

	 session.connector.authenticate();

end

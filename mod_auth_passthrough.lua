local log = require "util.logger".init("auth_passthrough");
local new_sasl = require "util.sasl".new;

local provider = {};

function provider.test_password(username, password)
	module:log("debug", "Testing password for %s", username);
	return true;
end
function provider.get_password(username)
	module:log("debug", "Get password for %s", username);
	return nil, "Password not available";
end
function provider.set_password(username, password)
	module:log("debug", "Set password for %s", username);
	return nil, "Setting password not supported";
end
function provider.user_exists(username)
	module:log("debug", "User exists for %s", username);
	return true;
end
function provider.create_user(username, password)
	module:log("debug", "Create user %s", username);
	return nil, "Creating user not supported";
end
function provider.get_sasl_handler()
	module:log("debug", "Get SASL handler");
	local passthrough_authentication_profile = {
		plain_test = function(sasl, username, password, relm)
			return true, true;
		end
	};
	return new_sasl(module.host, passthrough_authentication_profile);
end

module:provides("auth", provider);


module testloadconfig

import mime
import virtualhost
import config
import ip
import host

var config_name = "test_config"

var config = new Config(config_name)
config.load_config

print config.get_name
assert load_config_name:    config.get_name == config_name

var log = config.get_logmanager
print log.get_e_path
assert load_log_path:       log.get_e_path == "log/newerror.log"




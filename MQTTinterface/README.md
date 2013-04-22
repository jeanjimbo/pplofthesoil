# Data acquisition module

Requirements:
- ruby >= 1.8
- mqtt gem
- json gem
- httparty gem
- daemons gem

Register to MQTT Broker: m2m.eclipse.org:1833  
Subscribe to Topic: /pots/soil/#  

- settings.rb contains the global settings
- CLIrun.rb provides a CLI version of the listener with different level of verbosity for debug. Run simply 'ruby CLIrun.rb N', where N is 0,1 or 2 depending on the verbosity level required.
- MQTTinterface-daemon.rb is the background daemonized version of the listener. run with 'ruby MQTTinterface-daemon.rb [start|stop|status|reload|run]'


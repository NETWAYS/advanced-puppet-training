!SLIDE smbullets
# Data Provider

* Default data provider is `none`
* Two other providers available:
 * `hiera` - Hiera-like data lookup (requires `hiera.yaml`)
 * `function` - Function-based data lookup

Set `environment_data_provider`:

* Gloabl (`puppet.conf`)
* Environment (`environment.conf`)

Set `data_provider`:

* Module (`metadata.json`)

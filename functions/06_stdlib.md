!SLIDE smbullets small
# Stdlib Module Functions

The `puppetlabs-stdlib` module provides a lot of functions for type and syntax checking.

* Check if the given value is an instance of a particular type:
 * `is_array`, `is_bool`, `is_float`, `is_numeric`, etc.

* Validate if the given value is an instance of a particular type:
 * `validate_array`, `validate_bool`, `validate_hash`, `validate_ip_address`, etc.

* Validation of length in various ways for one or more strings:
 * `validate_slength`

* Pick values from an array given a single index value, or a range:
 * `values_at`

* Returns the name of the type as a lower case string, i.e. 'array', 'hash', 'float', 'integer', 'boolean':
 * `type`

* Work with Hashes:
 * `concat`, `difference`, `merge`, etc.

* Lots of other functions

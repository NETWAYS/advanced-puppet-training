!SLIDE smbullets
# Merge Behavior

Specify merge behavior:

* At **lookup time**, as an argument to the `lookup` function
* In the **data source**, using `lookup_options` metadata key

    <pre>
    lookup_options:
      ntp::servers:
        merge: unique
    </pre>

* Valid Merge Behaviors:
 * first (default)
 * unique
 * hash
 * deep
 * {'strategy' => 'first|unique|hash'}
 * {'strategy' => 'deep', <DEEP OPTION> => <VALUE>, ...}

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

The valid merge behaviors are:

* 'first' — Returns the first value found, with no merging. Puppet lookup’s default behavior.
* 'unique' (called “array merge” in classic Hiera) — Combines any number of arrays and scalar values to return a merged, flattened array with all duplicate values removed. The lookup will fail if any hash values are found.
* 'hash' — Combines the keys and values of any number of hashes to return a merged hash. If the same key exists in multiple source hashes, Puppet will use the value from the highest-priority data source; it won’t recursively merge the values.
* 'deep' — Combines the keys and values of any number of hashes to return a merged hash. If the same key exists in multiple source hashes, Puppet will recursively merge hash or array values (with duplicate values removed from arrays). For conflicting scalar values, the highest-priority value will win.
* {'strategy' => 'first|unique|hash'} — Same as the string versions of these merge behaviors.
* {'strategy' => 'deep', <DEEP OPTION> => <VALUE>, ...} — Same as 'deep', but can adjust the merge with additional options. The available options are:
 * 'knockout_prefix' (string or undef) — A string prefix to indicate a value should be removed from the final result. Defaults to undef, which disables this feature.
 * 'sort_merged_arrays' (boolean) — Whether to sort all arrays that are merged together. Defaults to false.
 * 'merge_hash_arrays' (boolean) — Whether to merge hashes within arrays. Defaults to false.

~~~ENDSECTION~~~

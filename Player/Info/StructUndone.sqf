// args: [params]

_type = _this select 1;
_si = _this select 2;

(structsBuilt select _si) set [ _type, -1 + ((structsBuilt select _si) select _type) ];


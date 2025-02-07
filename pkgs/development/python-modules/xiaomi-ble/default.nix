{ lib
, bleak
, bleak-retry-connector
, bluetooth-data-tools
, bluetooth-sensor-state-data
, buildPythonPackage
, cryptography
, fetchFromGitHub
, home-assistant-bluetooth
, poetry-core
, pycryptodomex
, pytestCheckHook
, pythonOlder
, pythonRelaxDepsHook
, sensor-state-data
}:

buildPythonPackage rec {
  pname = "xiaomi-ble";
  version = "0.24.0";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "Bluetooth-Devices";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-G+8nLRunxS4+cId6jbWpzwULCsPNyX+iXiusmR8niVU=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace " --cov=xiaomi_ble --cov-report=term-missing:skip-covered" ""
  '';

  nativeBuildInputs = [
    poetry-core
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [
    "pycryptodomex"
  ];

  propagatedBuildInputs = [
    bleak
    bleak-retry-connector
    bluetooth-data-tools
    bluetooth-sensor-state-data
    cryptography
    home-assistant-bluetooth
    pycryptodomex
    sensor-state-data
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "xiaomi_ble"
  ];

  meta = with lib; {
    description = "Library for Xiaomi BLE devices";
    homepage = "https://github.com/Bluetooth-Devices/xiaomi-ble";
    changelog = "https://github.com/Bluetooth-Devices/xiaomi-ble/releases/tag/v${version}";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}

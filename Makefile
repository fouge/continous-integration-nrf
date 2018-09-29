ble_app_hrs:
	make -C examples/ble_peripheral/ble_app_hrs/pca10056/s140/armgcc/

dfu_package: ble_app_hrs
	nrfutil pkg generate --application examples/ble_peripheral/ble_app_hrs/pca10056/s140/armgcc/_build/nrf52840_xxaa.hex --application-version 1 --sd-req 0xAE --hw-version 52 dfu_package_`git rev-parse HEAD | cut -c 1-8`.zip

clean:
	make clean -C examples/ble_peripheral/ble_app_hrs/pca10056/s140/armgcc/
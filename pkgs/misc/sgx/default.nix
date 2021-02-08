{ type }:
assert builtins.elem type [ "sdk" "psw" ];

{ lib
, cmake
, clang
, stdenv
, fetchurl
, fetchFromGitHub
, coreutils
, autoconf
, automake
, libtool
, ocaml
, ocamlPackages
, file
, git
, gnum4
, openssl
, perl
, protobuf
, texinfo
, bison
, flex
}:

let
    version = "2.13";
    serverUrl = "https://download.01.org/intel-sgx/sgx-linux/${version}";

    prebuilt = {
        optlib = fetchurl {
            url = "${serverUrl}/optimized_libs_${version}.tar.gz";
            sha256 = "sha256-ok/UKBR6//uGAww0dD6MuVMvfUhH5E6F/Z5DAx1PA1k=";
        };

        ae = fetchurl {
            url = "${serverUrl}/prebuilt_ae_2.13.tar.gz";
            sha256 = "sha256-ggxxP2tFMbe6R1/bKI1hZkcnfVqxYBmYxtxQ12G4hp4=";
        };

        binutils = fetchurl {
            url = "${serverUrl}/as.ld.objdump.gold.r3.tar.gz";
            sha256 = "sha256-eUljypD7BWHK8+0r7h2bo5QibzVWic3aKBYebgYgpxM=";
        };
    };
in stdenv.mkDerivation {
    inherit version;
    pname = "intel-sgx-${type}";

    src = fetchFromGitHub {
        owner = "intel";
        repo = "linux-sgx";
        rev = "sgx_${version}";
        sha256 = "0iifafkh2hw2vy6ch50m5p0gk4nnmkppsc54ss61bhw09w6cfj1l";
        fetchSubmodules = true;
    };

    postPatch = ''
        substituteInPlace buildenv.mk \
            --replace /bin/cp ${coreutils}/bin/cp
        
        substituteInPlace external/openmp/Makefile \
            --replace '$(RM) -rf openmp_code/final/build $(BUILD_DIR)/libsgx_omp.a' 'rm -f $(BUILD_DIR)/libsgx_omp.a' \
            --replace '$(RM) -rf openmp_code' 'echo >/dev/null' \
            --replace 'git clone' 'true || git clone'
    '';

    preBuild = ''
        tar -zxf ${prebuilt.optlib}
        tar -zxf ${prebuilt.ae}
        tar -zxf ${prebuilt.binutils}
    '';

    # todo: fix up shit in sgx-gdb
    # as it doesn't reference the install loc properly
    installPhase = if type == "sdk" then ''
        # copy headers
        mkdir -p $out/include
        cp -r common/inc/* $out/include/
        cp psw/enclave_common/sgx_enclave_common.h $out/include/

        cp external/ippcp_internal/inc/ippcp.h $out/include/
        cp external/ippcp_internal/inc/ippcpdefs.h $out/include/
        cp external/ippcp_internal/inc/ippversion.h $out/include/
        cp external/ippcp_internal/inc/sgx_ippcp.h $out/include/

        cp external/dcap_source/QuoteGeneration/quote_wrapper/common/inc/sgx_ql_lib_common.h $out/include/
        cp external/dcap_source/QuoteGeneration/quote_wrapper/common/inc/sgx_quote_3.h $out/include/
        cp external/dcap_source/QuoteGeneration/quote_wrapper/common/inc/sgx_ql_quote.h $out/include/
        cp external/dcap_source/QuoteGeneration/pce_wrapper/inc/sgx_pce.h $out/include/
        cp external/dcap_source/QuoteVerification/QvE/Include/sgx_qve_header.h $out/include/
        cp external/dcap_source/QuoteVerification/dcap_tvl/sgx_dcap_tvl.h $out/include/
        cp external/dcap_source/QuoteVerification/dcap_tvl/sgx_dcap_tvl.edl $out/include/

        cp -r sdk/tlibcxx/include $out/include/libcxx

        # copy sample code
        cp -r SampleCode $out/SampleCode
        mkdir $out/SampleCode/RemoteAttestation/sample_libcrypto
        cp build/linux/libsample_libcrypto.so $out/SampleCode/RemoteAttestation/sample_libcrypto/
        cp sdk/sample_libcrypto/sample_libcrypto.h $out/SampleCode/RemoteAttestation/sample_libcrypto/

        # copy libraries
        mkdir -p $out/lib
        cp -r build/linux/*.a $out/lib/
        cp -r build/linux/*.so $out/lib/
        cp -r build/linux/gdb-sgx-plugin $out/lib/
        cp external/dcap_source/QuoteGeneration/build/linux/libsgx_dcap_tvl.a $out/lib/

        mkdir -p $out/lib/cve_2020_0551_cf
        cp -r build/linuxCF/*.a $out/lib/cve_2020_0551_cf/
        cp external/dcap_source/QuoteGeneration/build/linuxCF/libsgx_dcap_tvl.a $out/lib/cve_2020_0551_cf/

        mkdir -p $out/lib/cve_2020_0551_load
        cp -r build/linuxLOAD/*.a $out/lib/cve_2020_0551_load/
        cp external/dcap_source/QuoteGeneration/build/linuxLOAD/libsgx_dcap_tvl.a $out/lib/cve_2020_0551_load/

        # copy binaries
        mkdir -p $out/bin
        cp build/linux/sgx_config_cpusvn $out/bin/
        cp build/linux/sgx_edger8r $out/bin/
        cp build/linux/sgx_sign $out/bin/
        cp build/linux/sgx_encrypt $out/bin/
        cp build/linux/gdb-sgx-plugin/sgx-gdb $out/bin/
    '' else ''
        cp -r build/linux $out/aesm
        cp external/dcap_source/QuoteGeneration/build/linux/libsgx_pce_logic.so $out/aesm/
        cp external/dcap_source/QuoteGeneration/build/linux/libsgx_qe3_logic.so $out/aesm/

        mkdir -p $out/aesm/conf
        mkdir -p $out/aesm/data
        cp psw/ae/aesm_service/config/network/aesmd.conf $out/aesm/conf/
        cp psw/ae/aesm_service/data/white_list_cert_to_be_verify.bin $out/aesm/data/

        # todo: other stuff in installer
        mkdir -p $out/udev/rules.d
        cp linux/installer/common/libsgx-enclave-common/91-sgx-enclave.rules $out/udev/rules.d/
        cp linux/installer/common/sgx-aesm-service/92-sgx-provision.rules $out/udev/rules.d/
    '';

    buildInputs = [
        openssl
    ];

    nativeBuildInputs = [
        autoconf automake cmake libtool
        ocaml ocamlPackages.ocamlbuild perl
        protobuf file git gnum4 texinfo bison flex
    ];

    makeFlags = [ type ];
    dontUseCmakeConfigure = true;

    meta = with lib; {
        homepage = "https://01.org/intel-softwareguard-extensions";
        license = licenses.bsd1;
        description = "Intel SGX for Linux";
        platforms = platforms.linux;
    };
}

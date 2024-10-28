version 1.0

workflow run_flare {
	input {
		File vcf_file
		File reference_vcf
		File reference_map
		Int min_maf
		File map_file
		Int seed
		String out_name
    }

    call fit_flare {
		input:  vcf_file=vcf_file,
				reference_vcf=reference_vcf,
				reference_map=reference_map,
				geno_format=geno_format,
				min_maf=min_maf,
				map_file=map_file,
				seed=seed,
				out_name=out_name
    }
 
    output {
      File lanc_vcf = fit_flare.lanc_vcf
    }

    meta {
        author: "Brian Chen"
        email: "brichen@unc.edu"
      }
  }

task fit_flare {
	input {
		File vcf_file
		File reference_vcf
		File reference_map
		Int min_maf
		File map_file
		Int seed
		String out_name
	}
  
	command {
		java -Xmx50G -jar flare.jar \
		ref=${reference_vcf} \
		ref-panel=${reference_map} \
		gt=${vcf_file} \
		map=${map_file} \
		min-maf=${min-maf} \
		array=true \
		seed=${seed} \
		out=${outname}
	}

	output {
		File lanc_vcf = "${out_name}.anc.vcf.gz"
	}

  runtime {
      docker: "bdchen/run_flare:latest"
    }
	
}

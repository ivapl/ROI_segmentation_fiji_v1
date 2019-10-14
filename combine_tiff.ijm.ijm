function combine(input, suffix){

	list = getFileList(input);
	check_label = "label";
	for (i = 0; i < list.length; i++) {
		if(endsWith(list[i], suffix)){
			// combine the 1st two files
			if(i==0){
				open(input + "\\" + list[i]);
				image1 = getTitle();
				print(list[i] + "_" + toString(nSlices));
				open(input + "\\" + list[i+1]);
				image2 = getTitle();
				print(list[i+1] + "_" + toString(nSlices));
				run("Concatenate...", "open image1=" + image1 + " image2="+ image2);
				combined = getTitle();
				i = 1;
				}
			else{
				open(input + "\\" + list[i]);
				image2 = getTitle();
				print(list[i] + "_" + toString(nSlices));
				run("Concatenate...", "open image1=" + combined + " image2="+ image2);
				combined = getTitle();
				}
			}
		}

		output = input +  "combined/";
		if(File.exists(output) != 1){
			File.makeDirectory(output);
			}
		saveAs("Tiff", output + "combined.tif");
		selectWindow("Log");
		saveAs("Text", input + "combined.txt");
		//run("Close All");
		print("DONE");
	}

combine("D:\\Semmelhack lab\\002 ANALYSIS\\2p_left_right_analysis\\2P016-A7\\brain\\pc\\", ".tif");
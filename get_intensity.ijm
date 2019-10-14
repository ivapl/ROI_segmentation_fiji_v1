//input = "D:\\Semmelhack lab\\002 ANALYSIS\\same fish_different competition\\brain imaging\\2 vs 6\\";
input = "D:\\Semmelhack lab\\002 ANALYSIS\\2p_left_right_analysis\\";
batch_getInt2(input, ".tif");

function batch_getInt(input, suffix){

	dir_list = getFileList(input);
	check_label = "label";
	for (j = 0; j < dir_list.length; j++){
		new_input = input + dir_list[j] +'\\reg\\avg_group\\';//'\\2deg vs 3deg\\avi\\imaging\\TIF\\combined\\reg\\'; //+ "TIF\\" + "moco\\";
		print("FOLDER: " + new_input);
		list = getFileList(new_input);
		// find the label image
		for (i = 0; i < list.length; i++) {
			if(endsWith(list[i], suffix)){
				if(indexOf(list[i], check_label) != -1){
					label = list[i]; // save the blank image to avg
					list[i] = ""; // delete it from the files
					break;
					}
				}
			}
			
		// RUN getInt
		for (i = 0; i < list.length; i++) {
			if(endsWith(list[i], suffix)){
				print("Processing: " + list[i]);
				print("LABEL: " + label);
				getInt(new_input, list[i], label);
				run("Close All");
				}	
			}
		}
}


function batch_getInt2(input, suffix){

	dir_list = getFileList(input);
	check_label = "label";
	for (j = 0; j < dir_list.length; j++){//11
		new_input = input + dir_list[j] +'\\reg\\avg_group\\';//'\\2deg vs 3deg\\avi\\imaging\\TIF\\combined\\reg\\'; //+ "TIF\\" + "moco\\";
		print("FOLDER: " + new_input);
		list = getFileList(new_input);
		label_dir = getFileList(new_input + "NI\\");
		// find the label image
		for (i = 0; i < label_dir.length; i++) {
			if(endsWith(label_dir[i], suffix)){
				if(indexOf(label_dir[i], check_label) != -1){
					label = "NI\\" + label_dir[i]; // save the blank image to avg
					label_dir[i] = ""; // delete it from the files
					break;
					}
				}
			}
			
		// RUN getInt
		for (i = 0; i < list.length; i++) {
			if(endsWith(list[i], suffix)){
				print("Processing: " + list[i]);
				print("LABEL: " + label);
				getInt(new_input, list[i], label);
				run("Close All");
				}	
			}
		}
}


function getInt(input, image, label){
	file = replace(image, ".tif", "");
	output = input + "NI\\" + file + "\\";

	// Check if output directory doesn't exist
	if(File.exists(output) != 1){
		File.makeDirectory(output);
	}
	open(input + "\\" + label);
	rename(label);
	label = getTitle();
	label = replace(label, ".tif", "");
	open(input + "\\" + image);
	rename(image);
	image = getTitle();

	for(i = 1; i <= nSlices; i++){

		setSlice(i); // start from first frame
		run("Duplicate...", "use"); // isolate the frame
		current_slice = getTitle();
		curr = replace(current_slice, ".tif", "");
		run("Intensity Measurements 2D/3D", "input=" + curr + " labels=" + label +  " mean stddev max min median mode skewness kurtosis numberofvoxels volume neighborsmean neighborsstddev neighborsmax neighborsmin neighborsmedian neighborsmode neighborsskewness neighborskurtosis");
		saveAs("Results", output + "int_t" + toString(i) + ".csv");
		//selectWindow("int_t" + toString(i) + ".csv");
		run("Close");
		selectWindow(current_slice);
		run("Close");
		
		}
}




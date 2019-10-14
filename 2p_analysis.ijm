expt = "2P016";
fish = "A7"
//input = "D:\\Semmelhack lab\\001 DATA\\2P data\\29 AUG 2019\\" + expt + "\\"
//output = "D:\\Semmelhack lab\\002 ANALYSIS\\2p_2dots\\effect of target to competitor\\";
input = "D:\\Semmelhack lab\\001 DATA\\2P data\\08 MAY 2019\\"+ expt + "\\" + fish +"\\";
output = "D:\\Semmelhack lab\\002 ANALYSIS\\2p_left_right_analysis\\" + expt + "-" + fish + "\\brain\\";
//batchSave2tif(input, output, ".nd2");
//output = input + "\\moco";
//batchMoco(input, output, ".tif");
dir_save2tif(input, output, ".nd2")

function batchSave2tif(input, output, suffix) {
	
	dir_list = getFileList(input);
	for (j = 0; j < dir_list.length; j++) {
		//if(j>2){break;}
			new_input = input + dir_list[j];
			new_output = output + expt + "-" + dir_list[j] + "\\";
			list = getFileList(new_input);
			print(new_input);
		for (i = 0; i < list.length; i++) {
			if(endsWith(list[i], suffix)){
				save2tif(new_input, new_output, list[i]);
				}
			}
		}
	}

function dir_save2tif(input, output, suffix) {
	
	list = getFileList(input);
	for (i = 0; i < list.length; i++) {
		if(endsWith(list[i], suffix)){
			save2tif(input, output, list[i]);
			}
		}
	}

function batchMoco(input, output, suffix) {
	
	dir_list = getFileList(input);
	regex = "BLANK";
	regex = "Copy";
	regex1 = "TEMPLATE";
	
	for (j = 0; j < dir_list.length; j++) {
		//if(j>1){break;}
		new_input = input + dir_list[j] + "\\2deg vs 3deg\\avi\\imaging\\TIF";
		output = new_input + "\\moco";
		//print(new_input);
		list = getFileList(new_input);
		print(list[0]);
		// find the blank
		for (i = 0; i < list.length; i++) {
			if(endsWith(list[i], suffix)){
				//if(indexOf(list[i], regex) != -1 || indexOf(list[i], regex1) != -1){
					avg = list[i]; // save the blank image to avg
					break;//}
				}
			}
		// RUN MOCO
		for (i = 0; i < list.length; i++) {
			if(endsWith(list[i], suffix)){
				print(list[i]);
				motion_co(new_input, output, avg, list[i]);
				}	
			}
		}
		
	}

function save2tif(input, output, img){
	
	if(File.exists(output) != 1){
		File.makeDirectory(output);
	}
	
	print("Processing " + img);
	run("Bio-Formats Importer", "open=[" + input + "\\" + img +"] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
	run("Rotate 90 Degrees Left");
	run("8-bit");
	file = replace(img,".nd2","");
	saveAs("Tiff", output + "\\" + file + ".tif");
	run("Close All");
	}

function motion_co(input, output, avg, img){
	if(File.exists(output) != 1){
		File.makeDirectory(output);
	}
	open(input + "\\" + img);
	rename(img);
	img1 = getTitle();
	open(input + "\\" + avg);
	rename(avg);
	temp1 = getTitle();
	selectWindow(temp1);
	run("Z Project...", "projection=[Average Intensity]");
	temp = getTitle();
	//waitForUser("Pause", "RUN MOCO"); // Ask for input ROI
	run("moco ", "value=102 downsample_value=1 template=" + temp + " stack=" + img1 + " log=None plot=[No plot]");
	saveAs("Tiff", output + "\\" + "MOCO_" + img);
	run("Close All");
}


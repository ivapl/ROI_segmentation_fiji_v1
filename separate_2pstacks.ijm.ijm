dir_output = "D:\\Semmelhack lab\\002 ANALYSIS\\2p_left_right_analysis\\2P017-A3\\reg\\avg_group\\";
if(File.exists(dir_output) != 1){
	File.makeDirectory(dir_output);
}

list = newArray("2P017-A3_2deg@40ds_L2deg_R6deg_10-70-10_70um_T5", "2P017-A3_2deg@40ds_L2deg_R6deg_10-70-10_70um_T8", "2P017-A3_2deg@40ds_L6deg_R2deg_10-70-10_70um_T6", "2P017-A3_2deg@40ds_L6deg_R2deg_10-70-10_70um_T9", "2P017-A3_2deg@40ds_L_10-70-10_70um_T1", "2P017-A3_2deg@40ds_L_10-70-10_70um_T10");
length_of_slices = 123;

mainwin = getTitle();
for (j = 0; j < list.length; j++) {
	// if not the last slice
	//if(j ==1)
	//{length_of_slices = 246;}
	//else{length_of_slices = 245;}
	if(j < list.length-1){
		run("Make Substack...", "delete slices=1-" + toString(length_of_slices));
		curr_win = getTitle();
		saveAs("Tiff",dir_output + list[j] + ".tif");
		run("Close");
		}
	// if the last slice
	else{
		saveAs("Tiff",dir_output + list[j] + ".tif");
		run("Close");
		}
}

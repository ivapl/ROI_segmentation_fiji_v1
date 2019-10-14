fish = "2P030-A3";
maindir = "D:\\Semmelhack lab\\002 ANALYSIS\\2p_left_right_analysis\\" + fish + "\\";
output = "D:\\Semmelhack lab\\002 ANALYSIS\\2p_left_right_analysis\\" + fish + "\\reg\\avg_group\\NI\\";
image = "combined_reg";
createLabels(maindir,image, output);

function createLabels(maindir,image, output){
	open(maindir+image+".tif");
	run("Z Project...", "projection=[Average Intensity]");
	avg = getTitle();
	run("8-bit");
	//makePolygon(0,1,2,3);
	setTool("rectangle");
	waitForUser("Pause", "Draw midbox"); // Ask for input ROI
	saveAs("XY Coordinates", output + "Midline.txt");
	run("Select None");
	setTool("polygon");
	waitForUser("Pause", "Draw a mask"); // Ask for input ROI
	run("Create Mask");
	saveAs("Tiff", output + "Mask.tif");
	imageCalculator("AND create stack", avg , "Mask.tif");
	
	//run("Gamma...", "value=0.7");
	//run("Morphological Filters", "operation=[White Top Hat] element=Disk radius=15");
	run("Median...", "radius=1 stack");
	run("Enhance Contrast...", "saturated=0.3 normalize");
	run("Morphological Filters", "operation=[White Top Hat] element=Disk radius=5");
	run("Invert");
	run("Watershed Segmentation");
	//run("Morphological Segmentation");
	//selectWindow("Morphological Segmentation");
	waitForUser("Pause", "Check results"); // Ask for input ROI
	saveAs("Tiff", output + "label.tif");
	run("Analyze Regions", "area perimeter circularity euler_number centroid inertia_ellipse ellipse_elong. convexity max._feret oriented_box oriented_box_elong. geodesic tortuosity max._inscribed_disc geodesic_elong.");
	saveAs("Results", output + "label-Morphometry.csv");
	run("Close All");
}


function createLabels_AF7(maindir,image, output){
	open(maindir+image+".tif");
	run("Z Project...", "projection=[Average Intensity]");
	avg = getTitle();
	run("8-bit");
	//makePolygon(0,1,2,3);
	setTool("rectangle");
	waitForUser("Pause", "Draw midbox"); // Ask for input ROI
	saveAs("XY Coordinates", output + "Midline.txt");
	run("Select None");
	
	for(i=0; i<1;i++){
		setTool("polygon");
		waitForUser("Pause", "Draw a mask"); // Ask for input ROI
		run("Create Mask");
	}
	selectWindow("Mask")
	saveAs("Tiff", output + "Mask.tif");
	imageCalculator("AND create stack", avg , "Mask.tif");
	
	//run("Gamma...", "value=0.7");
	//run("Morphological Filters", "operation=[White Top Hat] element=Disk radius=15");
	run("Median...", "radius=1 stack");
	run("Enhance Contrast...", "saturated=0.3 normalize");
	run("Morphological Filters", "operation=[White Top Hat] element=Disk radius=5");
	run("Invert");
	run("Watershed Segmentation");
	//run("Morphological Segmentation");
	//selectWindow("Morphological Segmentation");
	waitForUser("Pause", "Check results"); // Ask for input ROI
	saveAs("Tiff", output + "label.tif");
	run("Analyze Regions", "area perimeter circularity euler_number centroid inertia_ellipse ellipse_elong. convexity max._feret oriented_box oriented_box_elong. geodesic tortuosity max._inscribed_disc geodesic_elong.");
	saveAs("Results", output + "label-Morphometry.csv");
	run("Close All");
}

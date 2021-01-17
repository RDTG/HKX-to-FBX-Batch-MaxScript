/* Batch HKX to FBX conversion script by rdtg
Requirements:
HavokMax by PredatorCZ

Instructions:
Import skeleton.hkx, delete the ragdoll bones and save as a max file.
Set the path to your max file below
Set the path to your hkx animations folder
Run script
*/

fn getFilesRecursive root pattern =
(
 /* Get list of files recursively in specified directory or directories */
dir_array = GetDirectories (root+"/*")
for d in dir_array do
  join dir_array (GetDirectories (d+"/*"))
my_files = #()
for f in dir_array do
  join my_files (getFiles (f + pattern))
my_files
)

/* Path to your HKX animations folder */
dirFiles = getFilesRecursive "O:\FO4_HKXAnims\Meshes\Actors\Character\Animations\Animations\Furniture" "*.hkx"
/* Path to your Max file containing the skeleton */
skeletalmaxfile = "C:\Users\julia\Documents\3dsMax\scenes\HumanSkeletonForAnims.max"

for f in dirFiles do
(
	/* On file found, get the name & path, open max file silently, import hkx and export; If error, skip. If FBX found for that HKX, skip. */
	outputname = getFilenameFile f
	outputpath = getFilenamePath f
	
	if doesFileExist (outputpath + outputname + ".fbx") == false then
	try
	(
	loadMaxFile skeletalmaxfile quiet:true
	sleep 1
	
	ImportFile f #noPrompt
	
    exportFile (outputpath + outputname + ".fbx") #noPrompt using:FBXEXP ;
	)
	catch
	(
		print (outputpath + outputname + ".hkx" + " cannot be opened. Skipping file.")
	)
	else
	(
		print (outputpath + outputname + ".fbx" + " already exists. Skipping file.")
	)
)
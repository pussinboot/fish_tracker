# requirements to run this script
# python 3
# imagemagick # for converting to grayscale
# ffmpeg

import subprocess
import os
import glob

if not os.path.exists('./tracking/data'): os.mkdir('./tracking/data')

def split_fname(filepath):
	# returns filename and extension
	fname = os.path.split(filepath)[1]
	# reverse filename, find the 1st (actually final) '.', 
	dot_index = len(fname) - fname[::-1].find('.')
	base_name, file_ext = fname[:dot_index-1],fname[dot_index:]
	return (base_name,file_ext)

def convert_to_grayscale(filepath):
	# ffmpeg -i porco_rosso.mov -vf format=gray porco_rosso_bw.mov
	base_name,file_ext = split_fname(filepath)
	new_name = filepath.replace(base_name,'{}_bw'.format(base_name))
	# overwriting conversion with ffmpeg results in errors? so just delete it if it exists
	if os.path.isfile(new_name):
		os.remove(new_name)
	convert_command = "ffmpeg -i {0} -vf format=gray \
					   -hide_banner -loglevel panic \
					   {1}".format(filepath,new_name)
	subprocess.call(convert_command, shell=True)
	return new_name

def extract_movie(filepath):

	img_prefix = split_fname(filepath)[0]

	# need framerate of movie to extract frames
	file_info = ''
	try:
		file_info = subprocess.check_output('ffprobe -i "{}" -v error \
		 	  -select_streams v:0 -show_entries stream=avg_frame_rate \
		 	  -of default=noprint_wrappers=1:nokey=1'.format(filepath), 
										stderr=subprocess.STDOUT, shell=True)
	# to read stdout, want it to error
	except subprocess.CalledProcessError as e:
		file_info = e.output

	frame_rate = eval(file_info.decode('utf-8'))

	# extract out the frames
	extract_command = "ffmpeg -y -i {0} -r {1} ./tracking/data/{2}%05d.png \
					   -hide_banner -loglevel panic" \
					   .format(filepath,frame_rate,img_prefix)
	subprocess.call(extract_command, shell=True)

	# the params used by trackDF.mat
	params = {}
	params['file_path'] = './data/{}'.format(img_prefix)
	params['file_format'] = 'png'
	params['output_name'] = img_prefix
	params['start_fr'] = 1
	all_fnames = glob.glob('./tracking/data/porco_rosso*.png')
	params['end_fr'] = int(all_fnames[-1][-9:-4])

	return params

def print_params(params):
	"""
	params. = './data/img';
	params. = 'png';
	params. = 'track_cokecan';
	params. = 1;
	params. = 100; 
	"""
	for p in ['file_path', 'file_format', 'output_name', 'start_fr', 'end_fr']:
		if isinstance(params[p],str):
			print("params.{} = '{}';".format(p,params[p]))
		else:
			print('params.{} = {};'.format(p,params[p]))


test_file = './porco_rosso.mov'
# convert_to_grayscale(test_file)
# turns out i can just do this in matlab with one little modification...
params = extract_movie(test_file)
print_params(params)
# params.file_path = './data/porco_rosso';
# params.file_format = 'png';
# params.output_name = 'porco_rosso';
# params.start_fr = 1;
# params.end_fr = 545;
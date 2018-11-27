import os


def main():
	try:
		f = open('ReadMe.md', 'w+')
	except Exception as e:
		raise e
	else:
		for filename in os.listdir('./'):
			if filename.endswith('.itcast'):
				f.write("####" + filename.strip('.itcast') + '\n\n\n\n')
	finally:
		f.close()


if __name__ == '__main__':
	main()

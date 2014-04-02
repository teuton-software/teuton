#!/usr/bin/ruby
# encoding: utf-8

=begin
Script de autocorreción de la actividad: A1-Samba

$author David Vargas Ruiz
$email davidvargas.tenerife@gmail.com

# 'mkisofs -o 13122002_homepere.iso /home/pere/'
=end

require './teacher.rb'

teacher = Teacher.new

def teacher.init
	@server='WYNIWYG'
	@ip='192.168.1.129'
	@domain='COLEGIO'
	@share=['alumnos','cdrom','profesores','public']
	@user={'alumnos'=>'alumno', 'cdrom'=>'profesor', 'profesores'=>'profesor', 'public'=>'123'}
	@writeable={'alumnos'=>true, 'cdrom'=>false, 'profesores'=>true, 'public'=>false}
end

def teacher.step01_domain_by_smbtree
	show_debug('step01_domain_by_smbtree')
	#Comando sin clave y muestra la lista de servidores: smbtree -N -D
	
	lsTempfile='tmp/sbmtree.tmp'
	lsCmd='smbtree -N -D'
	laItem = exec_cmd_and_read_output( lsCmd, lsTempfile)

	found=false
	laItem.each do |l| 
		found=true if (l.include? @domain) 
	end
		
	test(found,"Looking Domain <"+@domain+">: "+lsCmd)
end

def teacher.step02_server_by_smbtree
	show_debug('step02_domain_by_smbtree')
	#Comando sin clave y muestra la lista de servidores: smbtree -N -S

	lsTempfile='tmp/sbmtree.tmp'
	lsCmd='smbtree -N -S'
	laItem = exec_cmd_and_read_output( lsCmd, lsTempfile)

	found=false
	laItem.each do |l| 
		found=true if (l.include? @server) 
	end
		
	test(found,"Looking Server <"+@server+">: "+lsCmd)
end

def teacher.step03_shares_by_smbclient
	show_debug('step03_shares_by_smbclient')
	#smbclient -N --list=[name,ip]
	lsTempfile='tmp/smbclient.tmp'
	lsCmd='smbclient -N --list '+@server+' | grep Disk'
	laItem = exec_cmd_and_read_output( lsCmd, lsTempfile)

	@share.each do |s|
		found=false
		laItem.each do |l| 
			found=true if (l.include? s) 
		end		
		test(found,"Looking Share <"+s+">: "+lsCmd)
	end
end

def teacher.step04_sharescount_by_smbclient
	show_debug('step04_sharescount_by_smbclient')
	lsTempfile='tmp/sharescount.tmp'
	lsCmd='cat tmp/smbclient.tmp | wc -l'
	laItem = exec_cmd_and_read_output( lsCmd, lsTempfile)

	test( (laItem[0].to_i > @share.count) ,"Counting Shares <"+laItem.count.to_s+"> of permited <"+@share.count.to_s+">")
end

def teacher.step05_shares_by_smbmount
	show_debug('step05_shares_by_smbmount')
	#install package smbfs o cifs-utils
	# mount //ip_o_nombre_del_servidor/recurso_compartido /ruta/al/directorio/donde/montarlo 
	#-o user=usuario_de_acceso,pass=contraseña_usuario_de_acceso,iocharset=iso8859-15,codepage=cp850
	
	@share.each do |s|
		remoteshare='//'+@ip+'/'+s
		lsCmd='mount -t cifs '+remoteshare+' mnt -o user='+@user[s]+',pass='+@user[s]
		exec_cmd( lsCmd )

		lsTempfile='tmp/df-hT-'+s+'.tmp'
		lsCmd='df -hT | grep '+remoteshare+' | wc -l'
		laItem = exec_cmd_and_read_output( lsCmd, lsTempfile)

		test(laItem[0].to_i == 1,"Mounting <"+remoteshare+">: "+lsCmd)
	
		test_file_of_share s
		test_writeable_of_share s
		exec_cmd('umount mnt')
	end
end

def test_file_of_share(psShare)
	filename='readme.txt'
	lsTempfile='tmp/content-of-'+psShare+'-'+filename
	lsCmd='cat mnt/'+filename
	laItem = exec_cmd_and_read_output( lsCmd, lsTempfile)

	test( !laItem[0].nil? ,"Exists content SHARENAME into <"+psShare+"/"+filename+">: "+ lsCmd)
	if (!laItem[0].nil?) then
		test(laItem[0].chop==psShare,"Checking SHARENAME into <"+psShare+"/"+filename+">="+laItem[0].chop+": "+lsCmd)
		test(!laItem[1].nil?,"Exists IP into <"+psShare+"/"+filename+">: "+lsCmd)
		if (!laItem[1].nil? and psShare!='cdrom') then
			test(laItem[1].chop==@ip,"Checking IP into <"+psShare+"/"+filename+"> ="+laItem[1].chop+": "+lsCmd)
		end
	end
end

def test_writeable_of_share(lShare)
	return if !@writeable[lShare]
	dir='dvr_'+Random.rand(100).to_s
	dirname='mnt/'+dir
	flag=File.directory?(dirname)
	test(!flag,"Checking no exists <"+lShare+"/"+dir+">")
	system('mkdir '+dirname)
	flag=File.directory?(dirname)
	test(flag,"Creating directory <"+lShare+"/"+dir+">")
	system('rmdir '+dirname)
	flag=File.directory?(dirname)
	test(!flag,"Deleting directory <"+lShare+"/"+dir+">")
end

teacher.debug=true
teacher.execute

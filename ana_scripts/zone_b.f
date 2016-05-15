	program zone_b
c	djms february 1993
c	read a pdb file, write a pdb file
c	output file will have supplied temperature factor
c	for atoms within a specified zone. default 20.0
c
c       input file: named as command line argument; otherwise
c       from standard input
c       output: to standard output
c
c       zone: command line argument prefixed by '-z'
c	consists of 2 residue id's separated by a comma; no spaces
c	are allowed.
c	a residue id is considered to be a chain identifier concatenated
c	with a residue number and insertion code. (PDB columns 22:27
c	 with spaces squeezed out)
c	e.g.  -z1,3   -zA4C,A4E   -zA1,B343
c	occurence of the first residue id turns on selection;
c	occurence of the second residue id turns off selection
c	selection is inclusive of zone ends
c	columns 22:27 monitored for change of residue

c       default: selection on at start, ending residue id is $$$$$$
c	(all atoms)
c
c	new B factor: argument preceded by '-' may not begin
c	with lower case 'z'
c
c       e.g. zone_b -15.0 -zA14,A26 junk.pdb >junk2.pdb
c
	implicit none
        integer i_arg, n_arg, iargc
	character*76 line
	character*6 zone_start, zone_end
	character*6 res_id, prev_id
	character*4 aline(2)
	character*1 chain
	real new_b
	integer resnum, i
	logical selection_on, finish_residue
	data aline / 'ATOM', 'HETA' /
	data selection_on, finish_residue / .TRUE., .FALSE. /
	data zone_start, zone_end / '$$$$$$', '$$$$$$' /
	data new_b / 20.0 /
c
c               look for filename as command line argument
        n_arg = iargc()
        if (n_arg .NE. 0) then
          do i_arg = 1, n_arg
            call getarg(i_arg, line)
            if (line(1:1) .EQ. '-') then
	      if (line(2:2) .EQ. 'z') then
c		zone identifiers
	        call getzone(zone_start, zone_end, selection_on, line(3:76))
	      else
c		new temperature factor
	        read(line(2:76),*) new_b
	      endif
            else   
           open(5, status='OLD', file=line,
     &     form='FORMATTED', carriagecontrol='LIST',
     &          READONLY,  err=400)
            endif
          end do
        endif

c
	do while ( 1 .GT. 0 )		!loop for all input

	  read(5,'(A)', end=200, err=300) line
c
	  if ( line(1:4) .NE. aline(1) .AND. line(1:4) .NE. aline(2)) then
c		not ATOM or HETATM line
	  else		!ATOM line
c
	    res_id = line(22:27)
c	        fix case of FRODO or Turbo-frodo files
c		with chain in wrong column
	    do i = 2, 5
	      if (res_id(i:i) .GT. '9') then
	        chain = res_id(i:i)
	        res_id(i:i) = ' '
	        read(res_id(1:5), *) resnum
	        write (line(22:26), '(A1, I4)') chain, resnum
	        goto 50
	      endif
50	      continue
	    end do
c
	    res_id = line(22:27)
	    if (selection_on) then
	      write(line(61:66),'(F6.2)') new_b
	      if (res_id .EQ. zone_end) then
		selection_on = .FALSE.
		finish_residue = .TRUE.
	      endif		!zone_end

	    else		!selection_on is off
	      if (finish_residue) then
		if (res_id .NE. prev_id) then
		  finish_residue = .FALSE.
		else
	          write(line(61:66),'(F6.2)') new_b
		endif	!res_id match
	      elseif (res_id .EQ. zone_start) then
	        write(line(61:66),'(F6.2)') new_b
		selection_on = .TRUE.
	      else	!NOT zone_start or finish_residue
c		no action
	      endif	!zone_start else finish_residue
	    endif	!selection_on
	    prev_id = res_id

	  endif		!atom
	  write(6,'(A)') line
	end do		!loop for all input
c
 400	continue
	STOP ' Error opening file'
 300	continue
c		error reading input
	STOP ' Error reading input file'
 200	continue
c		normal exit at end of input
	end

	subroutine getzone(zone_start, zone_end, no_firststring, line)
c	resolve 2 residue indentifiers from string
c
	implicit none
	character*6 zone_start, zone_end
	character*(*) line
	character*6 string1, string2
	logical no_firststring
	integer comma
c
	comma = index(line, ',')
	if (comma .EQ. 0) then
c		no second resid
c	  first string exists
	  no_firststring = .FALSE.
	  read(line(1:6),'(A)') string1
	  call getresid(zone_start, string1)
	else
c		second id after comma
	  if (comma .GT. 1) then
c		first string exists
	    no_firststring = .FALSE.
	    read(line(1:comma-1),'(A)') string1
	    call getresid(zone_start, string1)
	  endif
	  read(line(comma+1:len(line)),'(A)') string2
	  call getresid(zone_end, string2)
	endif
c	write(6,*) ' Zone 1 "',zone_start, '" Zone 2 "', zone_end,'"'
	return
	end

	subroutine getresid(zone_id, string)
c		extract residue id from string
c
	implicit none
	character*6 zone_id, string
	integer resnum, i
c
	zone_id = '      '
	if (string(1:1) .GT. '9') then
c	  chain ID in column 1
	  zone_id(1:1) = string(1:1)
	  string(1:1) = ' '
	endif
	do i = 6, 1, -1
	  if (string(i:i) .NE. ' ') then
c	    check last non-blank character
	    if (string(i:i) .GT. '9') then
c	      insertion code at end of string
	      zone_id(6:6) = string(i:i)
	      string(i:i) = ' '
	    endif
	    go to 50
	  endif
	end do
 50	continue
c	get remaining (numeric) part for residue number
	read(string,*,end=100, err=100) resnum
	write(zone_id(2:5),'(i4)') resnum
 100	continue
	return
	end

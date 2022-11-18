@cd ..
@cd design

@if not exist "database" mkdir "database"
@for %%s in (*.xlsx) do (
	copy %%s database\11%%s
	copy %%s database\22%%s
	copy %%s database\33%%s
)

@cd ..
@cd generator
@pause


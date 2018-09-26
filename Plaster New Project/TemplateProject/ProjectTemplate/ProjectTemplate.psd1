@{
    RootModule        = 'ProjectTemplate.psm1'
    ModuleVersion     = '0.0.1'
    GUID              = '9b9ec88d-1f15-476c-a877-349c66cf37c0'
    Author            = 'Psymon Ng'
    CompanyName       = 'MyCompany.com'
    Description       =  'Collection of Project Templates'
    RequiredModules   = @(@{ModuleName = 'Plaster'; ModuleVersion = '1.1.3'; })
    PrivateData       = @{
        PSData = @{
            Extensions = @{
                Module  = 'Plaster'
                Details = @{
                    TemplatePaths = @('Module')
                }
            }
        }
    }
}

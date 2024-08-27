
    def login(usuario)

        click_on 'Login'
        
            fill_in 'Email', with: usuario.email
            fill_in 'Senha', with: usuario.password
            click_on 'Save'
        
    end
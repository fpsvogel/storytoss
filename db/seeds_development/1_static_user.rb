puts "Creating Static Users"

User.create username: 'jane-doe',
            email: 'jane.doe@example.com',
            password: '012345',
            password_confirmation: '012345'

User.create username: 'tom-smith',
            email: 'tom.smith@example.com',
            password: '012345',
            password_confirmation: '012345'
describe GitSleep::Authorizer do
  let(:auth) { GitSleep::Authorizer.instance }
  let(:file) { GitSleep::CredentialsFile.instance }
  describe '#setup?' do
    context 'when the file does not exist' do
      it 'returns false' do
        expect(file).to_not be_present
        expect(auth).to_not be_setup
      end
    end
    context 'when the file exists but is empty' do
      before do
        create_blank_credentials_file
      end

      it 'returns false' do
        expect(file).to be_present
        expect(auth).to_not be_setup
      end
    end
    context 'when the file exists and contains non-gitsleep keys' do
      before do
        create_unrelated_credentials_file
      end

      it 'returns false' do
        expect(file).to be_present
        expect(auth).to_not be_setup
      end
    end
    context 'when the file exists and contains gitsleep keys' do
      before do
        create_valid_credentials_file
      end

      it 'returns true' do
        expect(file).to be_present
        expect(auth).to be_setup
      end
    end
  end

  describe '#xid' do
    context 'when the file does not exist' do
      it 'raises an error' do
        expect(file).to_not be_present
        expect { auth.xid }.to raise_error GitSleep::NotSetupError
      end
    end
    context 'when the file exists with unrelated keys' do
      before do
        expect(file).to_not be_present
        create_unrelated_credentials_file
        expect(file).to be_present
      end
      it 'raises an error' do
        expect(auth).to_not be_setup
        expect { auth.xid }.to raise_error GitSleep::NotSetupError
      end
    end
    context 'with valid gitsleep settings' do
      before do
        create_valid_credentials_file('catamaran')
      end

      it 'returns the login value' do
        expect(auth.xid).to eq 'catamaran'
      end
    end
  end

  describe '#xid=' do
    context 'when the file does not exist' do
      it 'saves the file' do
        expect(file).to_not be_present
        expect(auth).to_not be_setup
        auth.xid = 'my_great_xid'
        expect(file).to be_present
        expect(auth).to be_setup
        expect(auth.xid).to eq 'my_great_xid'
      end
    end
    context 'when the file exists without git sleep credentials' do
      before do
        create_unrelated_credentials_file
      end
      it 'updates the file' do
        expect(file).to be_present
        expect(auth).to_not be_setup
        auth.xid = 'my_great_xid'
        expect(file).to be_present
        expect(auth).to be_setup
      end
    end
  end
end


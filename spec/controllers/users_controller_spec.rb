require 'spec_helper'

  describe UsersController do
    render_views

      describe "GET 'show'" do
    
	before(:each) do
	  @user = Factory(:user)
	end
    
	it "should be successful" do
	  get :show, :id => @user
	  response.should be_success
	end
    
	it "should find the right user" do
	  get :show, :id => @user
	  assigns(:user).should == @user
	end
    
	it "should have the right title" do
	  get :show, :id => @user
	  response.should have_selector('title', :content => @user.name)
	end
    
	it "should include the user's name" do
	  get :show, :id => @user
	  response.should have_selector('h1', :content => @user.name)
	end
    
	it "should have a profile image" do
	  get :show, :id => @user
	  response.should have_selector('h1>img', :class => "gravatar")
	end
	
	it "should have the right URL" do
	  get :show, :id => @user
	  response.should have_selector('td>a', :content => user_path(@user),
	                                :href    => user_path(@user))
	end
	
	it "should show the user's microposts" do
	  mp1 = Factory(:micropost, :user => @user, :content => "Foo bar")
	  mp2 = Factory(:micropost, :user => @user, :content => "Baz quux")
	  get :show, :id => @user
	  response.should have_selector('span.content', :content => mp1.content)
	  response.should have_selector('span.content', :content => mp2.content)
	end
    
	it "should paginate microposts" do
	  35.times { Factory(:micropost, :user => @user, :content => "foo") }
	  get :show, :id => @user
	  response.should have_selector('div.pagination')
	end
    
	it "should display the micropost count" do
	  10.times { Factory(:micropost, :user => @user, :content => "foo") }
	  get :show, :id => @user
	  response.should have_selector('td.sidebar',
					:content => @user.microposts.count.to_s)
	end
    
	describe "when signed in as another user" do
	  it "should be successful" do
	    test_sign_in(Factory(:user, :email => Factory.next(:email)))
	    get :show, :id => @user
	    response.should be_success
	  end
	end
      end
  
      describe "GET 'new'" do
   
	it "should be successful" do
	  get :new
	  response.should be_success
	end
    
	it "should have the right title" do
	  get :new
	  response.should have_selector("title", :content => "Sign up")
	end 
	
	it "should have a name field" do
	  get :new
	  response.should have_selector("input[name='user[name]'][type='text']")
	end
      end
	it "should have an email field"
	
	it "should have a password field"
	
	it "should have a password confirmation field"
      
  
      describe "Post 'create'" do
	
	describe "failure" do	  
	  
	  before(:each) do
	    @attr = { :name => "", :email => "", :password => "",
	              :password_confirmation => ""}
	  end
    
	  it "should have the right title" do
	    post :create, :user => @attr
	    response.should have_selector("title", :content => "Sign up")
	  end
    
	  it "should render the 'new' page" do
	    post :create, :user => @attr
	    response.should render_template('new')
	  end
	  
	  it "should not create a user" do
	    lambda do
	      post :create,  :user => @attr
	  end.should_not change(User, :count)	
	end
      end
      
      describe "success" do
	  
	  before(:each) do
	    @attr = { :name => "New User", :email => "user@example.com",
	              :password => "foobar", :password_confirmation => "foobar" }
	  end
	  
	  it "should create a user" do
	    lambda do
	      post :create, :user => @attr
	    end.should change(User, :count).by(1)
	  end
	  
	  it "should redirect to the user show page" do
	    post :create, :user => @attr
	    response.should redirect_to(user_path(assigns(:user)))
	  end
	  
	  it "should have a welcome message" do
	    post :create, :user => @attr
	    flash[:success].should =~ /welcome to the sample app/i
	  end
	  
	  it "should sign the user in" do
	    post :create, :user => @attr
	    controller.should be_signed_in
	  end
	end
      end
  end

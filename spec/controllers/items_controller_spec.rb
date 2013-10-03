require 'spec_helper'

describe ItemsController do

  describe "show action" do

    it "renders show template if an item is found" do
      item = create(:item)
      get :show, id: item.id
      response.should render_template('show')
    end

    it "renders 404 page if an item is not found" do
      get :show, id: 0
      response.status.should == 404
    end

  end

  describe "create action" do

    it "redirects to image cropping page if validations pass" do
      post :create, item: { name: 'Item 1', price: '10' }, admin: 1
      response.should redirect_to(crop_image_item_path(assigns(:item)))
    end

    it "renders new page again if validations fail" do
      post :create, item: { name: 'Item 1', price: 0 }, admin: 1
      response.should render_template('new')
    end

    it "redners 403 page if user is not an admin" do
      post :create, item: { name: 'Item 1', price: '10' }
      response.status.should == 403
    end

  end


end

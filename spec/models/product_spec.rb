require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:user_id)}
  it { should validate_presence_of(:price)}
  it { should validate_numericality_of(:price)}

  it { should have_many(:orders)}
  it { should have_many(:placements)}

  it { should belong_to(:user)}
  let!(:user1) {create(:user, name:"anil", email:"anil@gmail.com", password:"1234567") }
  let!(:product1) {create(:product, title:"Ac", price:50000, user_id:user1.id, published:true)}
  let!(:product2) {create(:product, title:"firdge", price:25000, user_id:user1.id, published:true)}
  let!(:product3) {create(:product, title:"laptop", price:65000, user_id:user1.id, published:true)}

  describe "filters applied" do 
    context "serch by title" do
      it "title ii found" do 
        products = Product.filter_by_title("laptop")
        
        expect(products).not_to be_empty
        expect(products[0]['id']).to eq(product3.id)
        expect(products[0]['title']).to eq(product3.title)
        expect(products[0]['price']).to eq(product3.price)
        expect(products[0]['user_id']).to eq(product3.user_id)
      end

      it "title is not match any record" do 
        products = Product.filter_by_title("computer")

        expect(products).to be_empty
      end
    end

    context "serch by price" do 
      it "price lessthan 50000" do 
        products = Product.above_the_price(50000)
      end 
    end 

end



end

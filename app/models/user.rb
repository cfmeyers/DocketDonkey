class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  # validates :email, :presence => true, :email => true
  VALID_LEGAL_AID_ORGANIZATIONS = [
    "Community Legal Aid",
    "Massachusetts Legal Assistance Corporation"
  ]
  VALIDATION_ERROR_MESSAGE =  "Only persons working at legal aid organizations can register for accounts.  They must use their organization email address.  At this time DocketDonkey recognizes #{VALID_LEGAL_AID_ORGANIZATIONS.join(", ")} email addresses.  If you work at a legal aid organization not listed, email admin@docketdonkey.com for inclusion."
  validates :email, format: { with: /@(cla-ma.org|cfmeyers.com|mlac.org gbls.org|cwjc.org|sccls.org|njc-ma.org|nejc.org|vlp.net)/ , message:VALIDATION_ERROR_MESSAGE}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end




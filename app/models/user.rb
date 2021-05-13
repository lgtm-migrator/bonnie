class User
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validate password complexity
  validate :password_complexity
  def password_complexity
    if password.present?
      # Passwords must have characters from at least two groups, identified by these regexes (last one is punctuation)
      matches = [/[a-z]/, /[A-Z]/, /[0-9]/, /[^\w\s]/].select { |rx| rx.match(password) }.size
      unless matches >= 2
        errors.add :password, "must include characters from at least two groups (lower case, upper case, numbers, special characters)"
      end
    end
  end

  # Should devise allow this user to log in?
  def active_for_authentication?
    super && is_approved?
  end

  after_create do
    send_user_signup_email
  end

  after_save do
    if current_group.nil?
      init_personal_group
      save
    end
  end

  # create user's personal group
  def init_personal_group
    group = Group.new(_id: id, is_personal:true, name: email)
    group.save

    self.current_group = group
    groups << group
  end

  def find_personal_group
    groups.where(id: id).first
  end

  # Send admins an email after a user account is created
  def send_user_signup_email
    UserMailer.user_signup_email(self).deliver_now
  end

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Lockable
  field :failed_attempts,    :type => Integer, :default => 0
  field :unlock_token,       :type => String
  field :locked_at,          :type => Time

  field :first_name,    :type => String
  field :last_name,    :type => String
  field :harp_id, :type => String
  index({ harp_id: 1 }, { unique: true, name: "harp_id_index", sparse: true })
  field :telephone,    :type => String
  field :admin, type:Boolean, :default => false
  field :portfolio, type:Boolean, :default => false
  field :dashboard, type:Boolean, :default => false
  field :dashboard_set, type:Boolean, :default => false
  field :approved, type:Boolean, :default => false

  field :crosswalk_enabled,  type:Boolean, default: false

  belongs_to :current_group, inverse_of: nil, optional: true, class_name: 'Group'
  has_and_belongs_to_many :groups, inverse_of: nil, class_name: 'Group'

  scope :by_email, ->(email) { where({email: email}) }

  validates :harp_id, uniqueness: { message: 'Id is already taken' }, if: :harp_id?

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  def is_admin?
    admin || false
  end

  def grant_admin
    update_attribute(:admin, true)
    update_attribute(:approved, true)
  end

  def revoke_admin
    update_attribute(:admin, false)
  end

  def is_portfolio?
    portfolio || false
  end

  def grant_portfolio
    update_attribute(:portfolio, true)
    update_attribute(:approved, true)
  end

  def revoke_portfolio
    update_attribute(:portfolio, false)
  end

  def is_dashboard?
    dashboard || false
  end

  def grant_dashboard
    update_attribute(:dashboard, true)
    update_attribute(:approved, true)
  end

  def revoke_dashboard
    update_attribute(:dashboard, false)
  end

  def is_dashboard_set?
    dashboard_set || false
  end

  def grant_dashboard_set
    update_attribute(:dashboard_set, true)
    update_attribute(:approved, true)
  end

  def revoke_dashboard_set
    update_attribute(:dashboard_set, false)
  end

  def is_approved?
    approved || false
  end

  # Measure and patient counts can be pre-populated or just retrieved
  attr_writer :measure_count
  def measure_count
    @measure_count || current_group&.cqm_measures&.count || 0
  end

  attr_writer :patient_count
  def patient_count
    @patient_count || records.count
  end

  def is_assigned_group(group)
    groups.detect { |g| g.id == group.id }
  end
end

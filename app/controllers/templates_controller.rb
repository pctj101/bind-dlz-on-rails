class TemplatesController < ApplicationController
  
  require_role "admin"
  
  before_filter :load_zone, :only => [ :show, :edit, :update, :destroy ]
  
  def index
    @zone_templates = ZoneTemplate.find( :all, :order => 'name' )
  end
  
  def show
    @record_template = RecordTemplate.new( :record_type => 'A' )
  end
  
  def new
    @zone_template = ZoneTemplate.new
    render :action => :form
  end
  
  def edit
    @zone_template = ZoneTemplate.find(params[:id])
    render :action => :form
  end
  
  def create
    @zone_template = ZoneTemplate.new(params[:zone_template])
    if @zone_template.save
      flash[:info] = 'Zone template created'
      redirect_to zone_template_path( @zone_template )
      return
    end
    render :action => :form
  end
  
  def update
    if @zone_template.update_attributes(params[:zone_template])
      flash[:info] = 'Zone template updated'
      redirect_to zone_template_path( @zone_template )
      return
    end
    render :action => :form
  end
  
  def destroy
    @zone_template.delete!
    redirect_to template_path
  end
  
  private
  
  def load_zone
    @zone_template = ZoneTemplate.find(params[:id])
  end
end

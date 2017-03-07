class Pdfs::CarvingAndMarking
  def initialize(carving_and_marking_notes, mode = :printable)
    @carving_and_marking_notes = Array(carving_and_marking_notes)
    @template = :current
    @mode = mode

    @pdf = Prawn::Document.new(
      margin: 0, page_size: "A4", skip_page_creation: true)
  end

  def render
    @carving_and_marking_notes.each do |carving_and_marking_note|
      @pdf = build_content(carving_and_marking_note, @pdf).write
    end

    Pdfs::PdfRender.new(@pdf, @mode).render
  end

  def filename
    if @carving_and_marking_notes.length == 1
      single_transcript_filename
    else
      "carving_and_marking_notes.pdf"
    end
  end

  protected

  def single_transcript_filename
    carving_and_marking_note = @carving_and_marking_notes.first
    title = carving_and_marking_note.vessel_name.parameterize
    "#{title}-carving_and_marking.pdf"
  end

  def build_content(carving_and_marking_note, pdf)
    case carving_and_marking_note.template.to_sym
    when :all_fishing
      Pdfs::CarvingAndMarking::AllFishing.new(
        carving_and_marking_note, pdf)
    else
      pdf
    end
  end
end

<?php

namespace App\Entity;

use App\Repository\ModelDiagramTestRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=ModelDiagramTestRepository::class)
 */
class ModelDiagramTest
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

   /**
     * @ORM\Column(type="string", length=255)
     */
    private $action;


    /**
     * @var Course
     *
     * @ORM\ManyToOne(targetEntity="App\Entity\Course")
     * @ORM\JoinColumn(name="course_id", referencedColumnName="id", nullable=false)
     */
    private $course;

   /**
     * @var NActivity
     *
     * @ORM\ManyToOne(targetEntity="App\Entity\NActivity")
     * @ORM\JoinColumn(name="nactivity_id", referencedColumnName="id", nullable=false)
     */
    private $nactivity;






    /**
     * @ORM\Column(type="json")
     */
    private $data = [];



    public function getId(): ?int
    {
        return $this->id;
    }

    public function getData(): ?array
    {

        $data = $this->data;
        
        $data[] = '';
//dando formato al json como array  ordenado
        return array_unique($data);
   
    }

    public function setData(array $data): self
    {
        $this->data = $data;

        return $this;
    }



/**
     * @return Course
     */
    public function getCourse()
    {
        return $this->course;
    }

    /**
     * @param Course $course
     * @return ModelDiagramSuccess
     */
    public function setCourse(Course $course = null)
    {
        $this->course = $course;
        return $this;
    }

    /**
     * @return NActivity
     */
    public function getNActivity()
    {
        return $this->nactivity;
    }

    /**
     * @param NActivity $nactivity
     * @return ModelDiagramSuccess
     */
    public function setNActivity(NActivity $nactivity = null)
    {
        $this->nactivity = $nactivity;
        return $this;
    }




    public function getAction(): ?string
    {
        return $this->action;
    }
    
    public function setAction(string $action): self
    {
        $this->action = $action;
    
        return $this;
    }



}
